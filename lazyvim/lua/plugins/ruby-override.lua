return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			-- Remove erb tools specifically
			opts.ensure_installed = vim.tbl_filter(function(tool)
				return not vim.tbl_contains({ "erb-formatter", "erb-lint" }, tool)
			end, opts.ensure_installed)
		end,
	},
}
