-- See https://github.com/nvim-telescope/telescope.nvim
local file_ignore_patterns = {
  "^.git/",
  "^node_modules/",
  "^.rubocop.*/",
}

return {
  {
    "nvim-telescope/telescope.nvim", 
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files({ hidden = true, file_ignore_patterns = file_ignore_patterns }) end, desc = "Find Files" },
      { "<leader>fg", function() require("telescope.builtin").git_files() end, desc = "Find Git Files" },
      { "<leader>fG", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    },
  },
}