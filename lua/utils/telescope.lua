local telescope = require("telescope.builtin")
local M = telescope

---Fuzzy find in current buffer, preview hidden
M.fuzzy = function()
	telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
		prompt_title = "Search",
		prompt_prefix = "  ",
		borderchars = {
			prompt = { " " },
			results = { " " },
		},
	}))
end

--Fuzzy find in all open buffers
M.fuzzy_all_buffers = function()
	telescope.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end

M.nvim_settings = function()
	telescope.find_files({ cwd = vim.fn.stdpath("config") })
end

return M
