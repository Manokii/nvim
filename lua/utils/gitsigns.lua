local gitsigns = require("gitsigns")
local M = gitsigns

---@param pos "next" | "prev"
local moveToHunk = function(pos)
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gitsigns.nav_hunk(pos)
	end
end

M.next_hunk = function()
	moveToHunk("next")
end

M.prev_hunk = function()
	moveToHunk("prev")
end

M.stage_selected_hunk = function()
	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end

M.reset_selected_hunk = function()
	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end

M.diff_last_commit = function()
	gitsigns.diffthis("@")
end

return M
