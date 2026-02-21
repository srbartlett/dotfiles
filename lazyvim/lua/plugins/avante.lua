-- Disable since using Claude Code
if true then
	return {}
end

return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- for example
		-- provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				-- model = "claude-sonnet-4-20250514",
				model = "claude-sonnet-3-7",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			"MeanderingProgrammer/render-markdown.nvim",
			optional = true,
			ft = function(_, ft)
				vim.list_extend(ft, { "Avante" })
			end,
			opts = function(_, opts)
				opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
			end,
		},
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				spec = {
					{ "<leader>a", group = "ai" },
				},
			},
		},
	},
}
