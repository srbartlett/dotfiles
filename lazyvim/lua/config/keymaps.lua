-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.keymap.set("n", "<leader>fd", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify("Copied path: " .. path)
end, { desc = "Copy file path" })
