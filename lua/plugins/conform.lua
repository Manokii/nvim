return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
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
