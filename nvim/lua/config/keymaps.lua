-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")
map({ "x", "n", "s" }, "<leader>W", "<cmd>w<cr><esc>", { desc = "Save Buffer" })
vim.keymap.del({ "n", "t" }, "<c-_>")
vim.keymap.del({ "n", "t" }, "<c-/>")
map({ "n", "x" }, "<c-_>", "gcc", { desc = "Comment line", remap = true })
map({ "n" }, "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })
map({ "n" }, "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })

vim.keymap.del({ "n" }, "<C-k>")
vim.keymap.del({ "n" }, "<C-j>")
vim.keymap.del({ "n" }, "C-h")
vim.keymap.del({ "n" }, "<C-l>")
map({ "n" }, "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { remap = true })
map({ "n" }, "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { remap = true })
map({ "n" }, "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { remap = true })
map({ "n" }, "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { remap = true })
map({ "n" }, "<C-S>", "<Cmd>NvimTmuxNavigateRight<CR>", { remap = true })
map({ "n" }, "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", { remap = true })
