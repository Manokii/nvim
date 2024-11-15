return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "biomejs" },
				typescript = { "biomejs" },
				javascriptreact = { "biomejs" },
				typescriptreact = { "biomejs" },
				-- javascript = { "eslint" },
				-- typescript = { "eslint" },
				-- javascriptreact = { "eslint" },
				-- typescriptreact = { "eslint" },
			}
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
}
