-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>qq")

vim.keymap.del({ "n", "t" }, "<C-/>")
vim.keymap.del({ "n", "t" }, "<C-_>")
vim.keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

vim.keymap.set("n", "<leader>z", "<cmd>bdelete<cr>", { desc = "Close buffer" })
