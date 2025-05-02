return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
            theme = "ivy",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.git_files, {noremap = true, silent = true,  desc = 'Telescope find git files' })
      vim.keymap.set("n", "<leader-p>", builtin.find_files, {noremap = true, silent = true,  desc = 'Telescope find files' })
      vim.keymap.set("n", "<leader>a", builtin.live_grep, {noremap = true, silent = true,  desc = 'Telescope grep' })
      vim.keymap.set("n", "<C-e>", builtin.oldfiles, {noremap = true, silent = true,  desc = 'Telescope previously opened files' })
      -- vim.keymap.set("n", "<leader>gl", builtin.git_bcommits, {noremap = true, silent = true,  desc = 'Telescope git log for current file'})
      vim.keymap.set("n", "<leader>tm", builtin.keymaps, {noremap = true, silent = true,  desc = 'Telescope keymaps'})
      vim.keymap.set('n', '<C-w>', builtin.buffers, {noremap = true, silent = true,  desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>ff', builtin.grep_string, {noremap = true, silent = true,  desc = 'Telescope grep for word under cursor' })

      -- LSP 
      vim.keymap.set('n', '<leader>cs', builtin.lsp_document_symbols, {noremap = true, silent = true,  desc = 'Telescope code ref list symbols' })
      vim.keymap.set('n', '<leader>cd', builtin.lsp_definitions, { noremap = true, silent = true, desc = 'Telescope code ref goto definition' })
      vim.keymap.set('n', '<leader>cr', builtin.lsp_references, {noremap = true, silent = true,  desc = 'Telescope code ref goto references' })

      require("telescope").load_extension("ui-select")
    end,
  },
}
