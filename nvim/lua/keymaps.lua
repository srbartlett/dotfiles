-- space bar leader key
vim.g.mapleader = ";"

-- buffers
-- vim.keymap.set("n", "<leader>n", ":bn<cr>")
-- vim.keymap.set("n", "<leader>p", ":bp<cr>")
-- vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Key mappings for easier window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- telescope
-- vim.keymap.set("n", '<C-r>', ":Telescope find_files<cr>")
-- vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
-- vim.keymap.set("n", "<leader>a", ":Telescope live_grep<cr>")
-- vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")
-- vim.keymap.set('n', '<C-w>', ':Telescope buffers<cr>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>gl', ':Telescope buffers<cr>', { noremap = true, silent = true })

-- tree
-- vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- format code using LSP
vim.keymap.set("n", "<leader>fmd", vim.lsp.buf.format)

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- Commonly mistyped commands
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})


-- Snacks dashboard
vim.keymap.set('n', '<leader>s', ':Snacks<CR>', { noremap = true, silent = true, desc = "Snacks dashboard"})
--
-- Map <leader>w to create a vertical split and move to it
vim.keymap.set('n', '<leader>w', '<C-w>v<C-w>l', { noremap = true, silent = true })

-- Copy file path to buffer
vim.keymap.set('n', '<leader>cp', function()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { noremap = true, silent = true })

  -- Mappings.
  -- local opts = { buffer = bufnr, noremap = true, silent = true }
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, opts)
  -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  -- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
