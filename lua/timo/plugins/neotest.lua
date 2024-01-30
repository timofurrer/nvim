-- See https://github.com/nvim-neotest/neotest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Test Runners
      "nvim-neotest/neotest-go",
      "mrcjkb/neotest-haskell",
      "olimorris/neotest-rspec",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-go")({
            experimental = { test_table = true },
          }),
          require("neotest-haskell"),
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({"bundle", "exec", "rspec"})
            end,
          })
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup(opts)
    end,
    keys = {
      { '<leader>rt', function() require('neotest').run.run() end, desc = 'Run the nearest test' },
      { '<leader>rw', function() require('neotest').watch.toggle() end, desc = 'Toggle watching the nearest test' },
      { '<leader>rd', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug the nearest test' },
      { '<leader>rf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run the current file' },
      { '<leader>rl', function() require('neotest').run.run_last() end, desc = 'Repeat last test run' },
      { '<leader>rr', function() require('neotest').summary.toggle() end, desc = 'Open test summary' },
      { '<leader>ro', function() require('neotest').output.open({ enter = true }) end, desc = 'Open test output' },
    }
  }
}
