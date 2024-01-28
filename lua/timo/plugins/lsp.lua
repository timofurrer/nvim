return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "hls",
          "terraformls",
          "yamlls",
        },
      })

      require("lspconfig").yamlls.setup({
        settings = {
          yaml = {
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
          },
        },
      })

      -- Diagnostic config
      local config = {
        virtual_text = {
          severity = vim.diagnostic.severity.ERROR,
          spacing = 8,
          format = function(value)
            return string.format('%s: [%s] %s', value.source, value.code, value.message)
          end,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
      vim.diagnostic.config(config)

      -- This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(client, bufnr)
        local lsp_map = function(lhs, rhs, bufnr, desc)
          vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
        end

				lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
				lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
				lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
				lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

				lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
				lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
				lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
				lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
				lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")
				lsp_map("gH", vim.lsp.buf.hover, bufnr, "Hover")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })

				lsp_map("<leader>fo", "<cmd>Format<cr>", bufnr, "Format")
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local defaultCfg = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local lspconfig = require("lspconfig")
      lspconfig["lua_ls"].setup(defaultCfg)
      lspconfig["gopls"].setup(defaultCfg)
      lspconfig["terraformls"].setup(defaultCfg)
      lspconfig["yamlls"].setup(defaultCfg)
      lspconfig["hls"].setup(defaultCfg)
    end,
  },
}
