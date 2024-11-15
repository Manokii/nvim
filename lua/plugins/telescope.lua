return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	-- branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"build/",
					"dist/",
					"yarn.lock",
					"pnpm-lock.yaml",
					".git",
				},
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.94,
						height = 0.94,
						mirror = true,
						prompt_position = "top",
					},
					horizontal = {
						prompt_position = "top",
					},
				},
				sorting_strategy = "ascending",
			},
			-- pickers = {}
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_cursor(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}
