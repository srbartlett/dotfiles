return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
  },
  keys = {
    -- Define key mappings to load neotest
    { "<leader>tn", function() require("neotest").run.run() end, desc = "Run Neotest" },
    { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run Neotest File" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Re-Run the last test" },
    { "<leader>to", function() require("neotest").output.open({ enter = true}) end, desc = "Open test output" },
    { "<leader>tc", function() require("neotest").run.stop() end, desc = "Stop the currrently running test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")
      },
    })

    -- local neotest = require("neotest")
    -- vim.keymap.set("n", "<leader>tn", function()
    --   neotest.run.run()
    -- end, { desc = "Run the nearest test" })
    --
    -- vim.keymap.set("n", "<leader>tf", function()
    --   neotest.run.run(vim.fn.expand("%"))
    -- end, { desc = "Run all tests in the current file" })
    --
    -- vim.keymap.set("n", "<leader>tl", function()
    --   neotest.run.run_last()
    -- end, { desc = "Re-run the last test" })
    --
    -- vim.keymap.set("n", "<leader>to", function()
    --   neotest.output.open({ enter = true })
    -- end, { desc = "Open test output" })
    --
    -- vim.keymap.set("n", "<leader>ts", function()
    --   neotest.summary.toggle()
    -- end, { desc = "Toggle the test summary panel" })
    --
    -- vim.keymap.set("n", "<leader>ta", function()
    --   neotest.run.attach()
    -- end, { desc = "Attach to the nearest test" })
    --
    -- vim.keymap.set("n", "<leader>tc", function()
    --   neotest.run.stop()
    -- end, { desc = "Stop the currently running test(s)" })

  end
}
