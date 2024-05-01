return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			-- javascript = { 'eslint' },
			-- typescript = { 'eslint' },
			-- javascriptreact = { 'eslint' },
			-- typescriptreact = { 'eslint' },
		}
	end,
}
