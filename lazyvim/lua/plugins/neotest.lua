return {
	"nvim-neotest/neotest",
	branch = "fix/subprocess/load-adapters",
	dependencies = {
		"neotest-rspec",
	},
	opts = {
		log_level = vim.log.levels.DEBUG,
		adapters = { "neotest-rspec" },
	},
}
