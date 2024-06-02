return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 3000,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		-- formatters_by_ft = {
		-- 	javascript = { { "biome-check", "biome" } },
		-- 	typescript = { { "biome-check", "biome" } },
		-- 	javascriptreact = { { "biome-check", "biome" } },
		-- 	typescriptreact = { { "biome-check", "biome" } },
		-- 	svelte = { { "biome-check", "biome" } },
		-- 	css = { { "biome-check", "biome" } },
		-- 	html = { { "biome-check", "biome" } },
		-- 	json = { { "biome-check", "biome" } },
		-- 	yaml = { { "biome-check", "biome" } },
		-- 	markdown = { "biome" },
		-- 	grapql = { { "biome-check", "biome" } },
		-- 	lua = { "stylua" },
		-- },
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			svelte = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			grapql = { "prettierd" },
			lua = { "stylua" },
		},
	},
}
