-- See https://github.com/epwalsh/obsidian.nvim
return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/obsidian/vaults/default/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/obsidian/vaults/default/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "default",
        path = "~/obsidian/vaults/default",
      },
    },
    daily_notes = {
      folder = "Daily",
      date_format = "%Y/%m-%B/%Y-%m-%d-%A",
      template = "Templates/Daily Note Template.md"
    }
  },
  keys = {
    { "<leader>oo", "<cmd>:ObsidianOpen<cr>", desc = "Open Obsidian" },
    { "<leader>os", "<cmd>:ObsidianQuickSwitch<cr>", desc = "Quickly Switch Notes in Obsidian" },
    { "<leader>on", "<cmd>:ObsidianNew<cr>", desc = "New Note in Obsidian" },
    { "<leader>od", "<cmd>:ObsidianToday<cr>", desc = "Open Daily Note in Obsidian" },
    { "<leader>ot", "<cmd>:ObsidianTags<cr>", desc = "Search Tags in Obsidian" },
  },
}