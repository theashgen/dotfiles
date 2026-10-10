require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- user keys
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "lazygit" })
map("n", "<leader>bd", "<cmd>bd<CR>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
