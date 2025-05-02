return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = { "ruby_lsp" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    enabled = true,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities,
        settings = {
          rubyLsp = {
            diagnostics = false,
            completion = true,
            formatting = true,
            workspace = {
              symbol = { enable = true },
            },
          },
        }
      })

      lspconfig.stimulus_ls.setup({
        cmd = { "stimulus-language-server", "--stdio" },
        filetypes = { "javascript", "ruby", "typescript", "erb", "html" },
        root_dir = lspconfig.util.root_pattern('Gemfile', '.git'),
        -- root_dir = "app/javascript/controllers",
        -- root_dir = function(fname)
        --   return lspconfig.util.root_pattern("package.json", "stimulus.json", ".git")(fname)
        --   or lspconfig.util.find_git_ancestor(fname)
        --   or vim.fn.getcwd()
        -- end,
        settings = {
          stimulus = {
            controllerDirectories = { "app/javascript" } -- Adjust if your controllers are elsewhere
          }
        }
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {desc = "Code action"})
      vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {desc = "Code format"})
      -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end,
  },
}
