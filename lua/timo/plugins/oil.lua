-- See https://github.com/stevearc/oil.nvim
return {
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>Fo", ":Oil<cr>", desc = "Open Files with Oil" },
      { "<leader>FF", ":Oil --float<cr>", desc = "Open Files with Oil" },
    }
  }
}
