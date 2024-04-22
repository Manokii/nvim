return { -- Formatter
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			javascript = { { "biome-check", "biome" } },
			typescript = { { "biome-check", "biome" } },
			javascriptreact = { { "biome-check", "biome" } },
			typescriptreact = { { "biome-check", "biome" } },
			svelte = { { "biome-check", "biome" } },
			css = { { "biome-check", "biome" } },
			html = { { "biome-check", "biome" } },
			json = { { "biome-check", "biome" } },
			yaml = { { "biome-check", "biome" } },
			markdown = { { "biome-check", "biome" } },
			grapql = { { "biome-check", "biome" } },
			lua = { "stylua" },
		},
		-- formatters_by_ft = {
		-- 	javascript = { "prettier" },
		-- 	typescript = { "prettier" },
		-- 	javascriptreact = { "prettier" },
		-- 	typescriptreact = { "prettier" },
		-- 	svelte = { "prettier" },
		-- 	css = { "prettier" },
		-- 	html = { "prettier" },
		-- 	json = { "prettier" },
		-- 	yaml = { "prettier" },
		-- 	markdown = { "prettier" },
		-- 	grapql = { "prettier" },
		-- 	lua = { "stylua" },
		-- },
	},
}
