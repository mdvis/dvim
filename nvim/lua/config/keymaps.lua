local map = vim.keymap.set

map("n", "<leader><leader>t", "<cmd>SetTpl<cr>", { silent = true })
map("n", "<leader><cr>", "<cmd>noh<cr>", { silent = true })

map("n", "j", "gj")
map("n", "k", "gk")
map("n", "0", "^")
