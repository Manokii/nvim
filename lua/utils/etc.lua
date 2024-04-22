local conform = require("conform")
local lint = require("lint")
local comment_api = require("Comment.api")
local api = vim.api
local cur_buf = api.nvim_get_current_buf
local M = {}

local function buf_index(bufnr)
	for i, value in ipairs(vim.t.bufs) do
		if value == bufnr then
			return i
		end
	end
end

M.whichkey_lookup = function()
	vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end

M.format = function()
	conform.format({ lsp_fallback = true })
end

M.lint = lint.try_lint
M.toggle_comment_visual = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
M.toggle_comment_line = comment_api.toggle.linewise.current

M.set_cleanbuf_opts = function(ft)
	local opt = vim.opt_local

	opt.buflisted = false
	opt.modifiable = false
	opt.buftype = "nofile"
	opt.number = false
	opt.list = false
	opt.wrap = false
	opt.relativenumber = false
	opt.cursorline = false
	opt.colorcolumn = "0"
	opt.foldcolumn = "0"

	vim.opt_local.filetype = ft
	vim.g[ft .. "_displayed"] = true
end

M.close_buffer = function(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		-- for those who have disabled tabufline
		if not vim.t.bufs then
			vim.cmd("bd")
			return
		end

		bufnr = bufnr or cur_buf()
		local curBufIndex = buf_index(bufnr)
		local bufhidden = vim.bo.bufhidden

		-- force close floating wins
		if bufhidden == "wipe" then
			vim.cmd("bw")
			return

		-- handle listed bufs
		elseif curBufIndex and #vim.t.bufs > 1 then
			local newBufIndex = curBufIndex == #vim.t.bufs and -1 or 1
			vim.cmd("b" .. vim.t.bufs[curBufIndex + newBufIndex])

		-- handle unlisted
		elseif not vim.bo.buflisted then
			local tmpbufnr = vim.t.bufs[1]

			if vim.g.nv_previous_buf and vim.api.nvim_buf_is_valid(vim.g.nv_previous_buf) then
				tmpbufnr = vim.g.nv_previous_buf
			end

			vim.cmd("b" .. tmpbufnr .. " | bw" .. bufnr)
			return
		else
			vim.cmd("enew")
		end

		if not (bufhidden == "delete") then
			vim.cmd("confirm bd" .. bufnr)
		end
	end

	vim.cmd("redrawtabline")
end

return M
