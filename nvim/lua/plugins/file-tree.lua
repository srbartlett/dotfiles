  -- File tree
  return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        git = {
          enable = true,
        },
        -- log = {
        --   enable = true,
        --   truncate = true,
        --   types = {
        --     all = false,
        --     config = false,
        --     copy_paste = false,
        --     dev = false,
        --     diagnostics = true,
        --     git = true,
        --     profile = true,
        --     watcher = true,
        --   },
        -- },
      })

      vim.keymap.set("n", "<leader>e", ":NvimTreeFindFile<cr>")
      vim.keymap.set("n", "<leader>r", ":NvimTreeOpen<cr>")
    end
  }

