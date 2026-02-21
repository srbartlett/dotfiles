-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.relativenumber = false -- relative line numbers
-- Auto save
vim.api.nvim_create_autocmd("FocusLost", {
	pattern = "*",
	command = "wa",
})

vim.g.maplocalleader = ";"
