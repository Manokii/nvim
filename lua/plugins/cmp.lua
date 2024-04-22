return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {},
		},
		"saadparwaiz1/cmp_luasnip",

		--  nvim-cmp does not ship with all sources by default. They are split
		--  into multiple repos for maintenance purposes.
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local opts = {
			icons = true,
			lspkind_text = true,
		}

		local formatting_style = {
			-- default fields order i.e completion word + item.kind + item.kind icons
			fields = { "abbr", "kind", "menu" },

			format = function(_, item)
				local icons = {
					Namespace = "󰌗",
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰆧",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈚",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "󰊄",
					Table = "",
					Object = "󰅩",
					Tag = "",
					Array = "[]",
					Boolean = "",
					Number = "",
					Null = "󰟢",
					String = "󰉿",
					Calendar = "",
					Watch = "󰥔",
					Package = "",
					Copilot = "",
					Codeium = "",
					TabNine = "",
				}
				local icon = (opts.icons and icons[item.kind]) or ""

				icon = opts.lspkind_text and ("\t\t" .. icon .. " ") or icon
				item.kind = string.format("%s %s", icon, opts.lspkind_text and item.kind or "")

				return item
			end,
		}

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		local options = {
			completion = {
				completeopt = "menu,menuone",
			},

			window = {
				completion = {
					side_padding = 1,
					winhighlight = "Normal:DefaultFloat,CursorLine:DefaultSelection,Search:None",
					scrollbar = false,
				},
				documentation = {
					border = border("CmpDocBorder"),
					winhighlight = "Normal:DefaultFloat",
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			formatting = formatting_style,

			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
				--['<Tab>'] = cmp.mapping.select_next_item(),
				--['<S-Tab>'] = cmp.mapping.select_prev_item(),

				-- <c-l> will move you to the right of each of the expansion locations.
				-- <c-h> is similar, except moving you backwards.
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
			},
		}

		options.window.completion.border = border("CmpBorder")

		cmp.setup(options)
	end,
}
