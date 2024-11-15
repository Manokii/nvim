local noice_search = {
	view = "cmdline",
	opts = {
		align = "bottom",
		size = { width = "100%" },
		position = { row = "100%", col = "0" },
		border = { style = "none", padding = { 0, 0 } },
	},
}

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					search_down = noice_search,
					search_up = noice_search,
				},
				opts = {
					align = "center",
					position = { row = 2, col = "50%" },
					border = { style = "none", padding = { 1, 2 } },
					win_options = {
						winhighlight = { Normal = "NormalFloat", FloatBorder = "NormalFloat" },
					},
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				-- bottom_search = true, -- use a classic bottom cmdline for search
				-- command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				-- lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			-- "rcarriga/nvim-notify",
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			local function show_macro_recording()
				local recording_register = vim.fn.reg_recording()
				if recording_register == "" then
					return ""
				else
					return "Recording @" .. recording_register
				end
			end

			require("lualine").setup({
				sections = {
					lualine_x = {
						{
							"macro-recording",
							fmt = show_macro_recording,
							color = { fg = "#ff9e64" },
						},
					},
				},
			})
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			local wk = require("which-key")
			wk.setup()

			-- Document existing key chains
			wk.add({
				{ "<leader>c", desc = "Code" },
				{ "<leader>d", desc = "Document" },
				{ "<leader>r", desc = "Rename" },
				{ "<leader>f", desc = "Find" },
				{ "<leader>w", desc = "WhichKey" },
				{ "<leader>t", desc = "Toggle" },
				{ "<leader>g", desc = "Goto LSP" },
				{ "<leader>h", desc = "Git hunk" },
				{
					mode = "v",
					{ "<leader>h", "Git [H]unk" },
				},
			})
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
		opts = function()
			local transparent = true

			if vim.g.neovide then
				transparent = false
			end

			return {
				transparent = transparent,
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
					custom = { "^.git$", "^node_modules" },
				},
				disable_netrw = true,
				hijack_netrw = true,
				hijack_cursor = true,
				hijack_unnamed_buffer_when_opening = false,
				sync_root_with_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				view = {
					adaptive_size = true,
					side = "left",
					width = 30,
					preserve_window_proportions = true,
				},
				git = { enable = true },
				filesystem_watchers = {
					enable = true,
				},
				actions = {
					open_file = {
						resize_window = true,
					},
				},
				renderer = {
					root_folder_label = false,
					highlight_git = true,
					highlight_opened_files = "none",

					indent_markers = {
						enable = true,
					},

					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = false,
							git = true,
						},

						glyphs = {
							default = "󰈚",
							symlink = "",
							folder = {
								default = "",
								empty = "",
								empty_open = "",
								open = "",
								symlink = "",
								symlink_open = "",
								arrow_open = "",
								arrow_closed = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
						},
					},
				},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
}
