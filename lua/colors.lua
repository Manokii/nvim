local colors = require("tokyonight.colors").setup()

local HL_Colors = {
	TelescopeMatching = { fg = colors.fg },
	TelescopeSelection = { fg = colors.fg, bg = colors.bg_highlight, bold = true },

	TelescopePromptPrefix = { bg = colors.bg_highlight, fg = colors.warning },
	TelescopePromptNormal = { bg = colors.bg_highlight },
	TelescopePromptBorder = { bg = colors.bg_highlight, fg = colors.bg_highlight },
	TelescopePromptTitle = { bg = colors.bg_search, fg = colors.fg },

	TelescopePreviewNormal = { bg = colors.bg_sidebar },
	-- TelescopePreviewBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },
	-- TelescopePreviewTitle = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },

	TelescopeResultsNormal = { bg = colors.bg_sidebar },
	TelescopeResultsBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },
	TelescopeResultsTitle = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },

	DefaultNormal = { bg = colors.bg, fg = colors.fg },
	DefaultFloat = { bg = colors.bg_sidebar, fg = colors.fg },
	DefaultBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },
	DefaultTitle = { bg = colors.bg_search, fg = colors.fg },
	DefaultHighlight = { bg = colors.bg_highlight, fg = colors.fg },
	DefaultSelection = { fg = colors.fg, bg = colors.bg_highlight, bold = true },
	BorderDark = { bg = colors.bg_sidebar, fg = colors.bg },

	Yellow = { bg = colors.yellow, fg = colors.black },
	Cyan = { bg = colors.cyan, fg = colors.black },
	Teal = { bg = colors.teal, fg = colors.black },
	Error = { bg = colors.error, fg = colors.black },
	Info = { bg = colors.info, fg = colors.black },

	CmpDocBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },
	CmpCompletion = { bg = colors.bg_sidebar, fg = colors.bg_highlight },
	CmpBorder = { bg = colors.bg_sidebar, fg = colors.bg_sidebar },
}

for hl, col in pairs(HL_Colors) do
	vim.api.nvim_set_hl(0, hl, col)
end
