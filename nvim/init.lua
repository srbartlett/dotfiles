local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('options')
require('keymaps')
require("lazy").setup("plugins")


-- disable swap
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- Reload config without closing 
function ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end
vim.api.nvim_set_keymap("n", "<leader>ev", ":lua ReloadConfig()<CR>", { noremap = true, silent = true })



vim.lsp.set_log_level("debug")

--require('plugins.lazy')
--require('plugins.keymaps')
--require('plugins.options')
