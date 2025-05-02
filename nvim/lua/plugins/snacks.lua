return {
  "folke/snacks.nvim",
  priority = 1000,
  enabled = true,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { 
      enabled = true, 
      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
        { section = "startup" },
      },
    },
    -- indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    git = { 
      enabled = true,
      branch = main,
    },
    words = { enabled = false },
    lazygit = { enabled = true },
  },
  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gl", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
  },
}
