local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Lazy
map("n", "<leader>L", function() require("lazy").show() end, "Show Lazy")

-- Diagnostics
map("n", "gx", vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Buffers
map("n", "<leader><left>", "<cmd>bprevious<cr>", "Switch to buffer to the left")
map("n", "<leader><right>", "<cmd>bnext<cr>", "Switch to buffer to the right")
map("n", "<leader>h", "<cmd>bprevious<cr>", "Switch to buffer to the left")
map("n", "<leader>l", "<cmd>bnext<cr>", "Switch to buffer to the right")
