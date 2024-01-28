-- See https://github.com/folke/todo-comments.nvim
return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>tt", ":TodoTelescope<cr>", desc = "Open Todo Telescope" },
    },
  }
}
