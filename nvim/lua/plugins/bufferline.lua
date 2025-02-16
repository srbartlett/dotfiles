  -- Visualize buffers as tabs
  return {
    'akinsho/bufferline.nvim', 
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup {}
      diagnostics = "nvim_lsp"
      vim.keymap.set('n', '<leader>j', '<cmd>BufferLineCycleNext<CR>', { desc="Bufferline next", noremap = true, silent = true })
      vim.keymap.set('n', '<leader>b', '<cmd>BufferLinePick<CR>', { desc= "Bufferline pick", noremap = true, silent = true })
    end
  }

