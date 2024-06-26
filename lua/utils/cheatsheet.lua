local utils = require("utils.etc")
vim.api.nvim_create_autocmd("BufWinLeave", {
	callback = function()
		if vim.bo.ft == "cheatsheet" then
			vim.g.cheatsheet_displayed = false
		end
	end,
})

local getLargestWin = function()
	local largest_win_width = 0
	local largest_win_id = 0

	for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local tmp_width = vim.api.nvim_win_get_width(winid)

		if tmp_width > largest_win_width then
			largest_win_width = tmp_width
			largest_win_id = winid
		end
	end

	return largest_win_id
end

local get_mappings = function(mappings, tb_to_add, mode)
	for _, v in ipairs(mappings) do
		local desc = v.desc

		if not desc or (select(2, desc:gsub("%S+", "")) <= 1) then
			goto continue
		end

		-- skip if desc is not starting with word
		if not string.sub(desc, 1, 1):match("%w") then
			goto continue
		end

		if v.lhs:match("<Plug>") then
			goto continue
		end

		local heading = desc:match("%S+")

		-- blocklist
		local blocklist = {
			"autopairs",
		}

		for _, item in ipairs(blocklist) do
			if heading == item then
				goto continue
			end
		end
		local heading_with_mode = desc:match("%S+") .. (mode ~= "Normal" and " [" .. mode .. "]" or "")

		if not tb_to_add[heading_with_mode] then
			tb_to_add[heading_with_mode] = {}
		end

		local keybind = string.sub(v.lhs, 1, 1) == " " and "<leader> +" .. v.lhs or v.lhs

		desc = v.desc:match("%s(.+)") -- remove first word from desc

		-- dont include desc which have \n
		if not string.find(desc, "\n") then
			table.insert(tb_to_add[heading_with_mode], { desc, keybind })
		end

		::continue::
	end
end

local organize_mappings = function(tb_to_add)
	local modes = { "n", "i", "v", "t" }
	local modeStrings = {
		n = "Normal",
		i = "Insert",
		v = "Visual",
		t = "Term",
	}

	for _, mode in ipairs(modes) do
		local keymaps = vim.api.nvim_get_keymap(mode)
		get_mappings(keymaps, tb_to_add, modeStrings[mode])

		local bufkeymaps = vim.api.nvim_buf_get_keymap(0, mode)
		get_mappings(bufkeymaps, tb_to_add, modeStrings[mode])
	end

	-- remove groups which have only 1 mapping
	for key, x in pairs(tb_to_add) do
		if #x <= 1 then
			tb_to_add[key] = nil
		end
	end
end

local ascii = {
	"                                      ",
	"                                      ",
	"                                      ",
	"█▀▀ █░█ █▀▀ ▄▀█ ▀█▀ █▀ █░█ █▀▀ █▀▀ ▀█▀",
	"█▄▄ █▀█ ██▄ █▀█ ░█░ ▄█ █▀█ ██▄ ██▄ ░█░",
	"                                      ",
	"                                      ",
	"                                      ",
}

local cheatsheet_draw = function()
	local cheatsheet = vim.api.nvim_create_namespace("cheatsheet")

	local mappings_tb = {}
	organize_mappings(mappings_tb)

	vim.g.previous_buf = vim.api.nvim_get_current_buf()
	local buf = vim.api.nvim_create_buf(false, true)

	-- add left padding (strs) to ascii so it looks centered
	local ascii_header = vim.tbl_values(ascii)

	local win = getLargestWin()
	vim.api.nvim_set_current_win(win)

	local ascii_padding = (vim.api.nvim_win_get_width(win) / 2) - (#ascii_header[1] / 2)

	for i, str in ipairs(ascii_header) do
		ascii_header[i] = string.rep(" ", ascii_padding) .. str
	end

	-- set ascii
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, ascii_header)

	-- column width
	local column_width = 0
	for _, section in pairs(mappings_tb) do
		for _, mapping in pairs(section) do
			local txt = vim.fn.strdisplaywidth(mapping[1] .. mapping[2])
			column_width = column_width > txt and column_width or txt
		end
	end

	-- 10 = space between mapping txt , 4 = 2 & 2 space around mapping txt
	column_width = column_width + 10

	local win_width = vim.api.nvim_win_get_width(win) - vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].textoff - 4
	local columns_qty = math.floor(win_width / column_width)

	column_width = math.floor((win_width - (column_width * columns_qty)) / columns_qty) + column_width

	-- add mapping tables with their headings as key names
	local cards = {}
	local card_headings = {}

	for name, section in pairs(mappings_tb) do
		for _, mapping in ipairs(section) do
			local padding_left = math.floor((column_width - vim.fn.strdisplaywidth(name)) / 2)

			-- center the heading
			name = string.rep(" ", padding_left)
				.. name
				.. string.rep(" ", column_width - vim.fn.strdisplaywidth(name) - padding_left)

			table.insert(card_headings, name)

			if not cards[name] then
				cards[name] = {}
			end

			table.insert(cards[name], string.rep(" ", column_width))

			local whitespace_len = column_width - 4 - vim.fn.strdisplaywidth(mapping[1] .. mapping[2])
			local pretty_mapping = mapping[1] .. string.rep(" ", whitespace_len) .. mapping[2]

			table.insert(cards[name], "  " .. pretty_mapping .. "  ")
		end
		table.insert(cards[name], string.rep(" ", column_width))
		table.insert(cards[name], string.rep(" ", column_width))
	end

	-- divide cheatsheet layout into columns
	local columns = {}

	for i = 1, columns_qty, 1 do
		columns[i] = {}
	end

	local function getColumn_height(tb)
		local res = 0

		for _, value in pairs(tb) do
			res = res + #value + 1
		end

		return res
	end

	local function append_table(tb1, tb2)
		for _, val in ipairs(tb2) do
			tb1[#tb1 + 1] = val
		end
	end

	local cards_headings_sorted = vim.tbl_keys(cards)

	-- imitate masonry layout
	for _, heading in ipairs(cards_headings_sorted) do
		for column, mappings in ipairs(columns) do
			if column == 1 and getColumn_height(columns[1]) == 0 then
				columns[1][1] = cards_headings_sorted[1]
				append_table(columns[1], cards[cards_headings_sorted[1]])
				break
			elseif column == 1 and getColumn_height(mappings) < getColumn_height(columns[#columns]) then
				columns[column][#columns[column] + 1] = heading
				append_table(columns[column], cards[heading])
				break
			elseif column == 1 and getColumn_height(mappings) == getColumn_height(columns[#columns]) then
				columns[column][#columns[column] + 1] = heading
				append_table(columns[column], cards[heading])
				break
			elseif column ~= 1 and (getColumn_height(columns[column - 1]) > getColumn_height(mappings)) then
				if not vim.tbl_contains(columns[1], heading) then
					columns[column][#columns[column] + 1] = heading
					append_table(columns[column], cards[heading])
				end
				break
			end
		end
	end

	local longest_column = 0

	for _, value in ipairs(columns) do
		longest_column = longest_column > #value and longest_column or #value
	end

	local max_col_height = 0

	-- get max_col_height
	for _, value in ipairs(columns) do
		max_col_height = max_col_height < #value and #value or max_col_height
	end

	-- fill empty lines with whitespaces
	-- so all columns will have the same height
	for i, _ in ipairs(columns) do
		for _ = 1, max_col_height - #columns[i], 1 do
			columns[i][#columns[i] + 1] = string.rep(" ", column_width)
		end
	end

	local result = vim.tbl_values(columns[1])

	-- merge all the column strings
	for index, value in ipairs(result) do
		local line = value

		for col_index = 2, #columns, 1 do
			line = line .. "  " .. columns[col_index][index]
		end

		result[index] = line
	end

	vim.api.nvim_buf_set_lines(buf, #ascii_header, -1, false, result)

	local highlight_groups = {
		"TelescopePromptTitle",
		"Yellow",
		"Cyan",
		"Teal",
		"Error",
		"Info",
	}

	-- add highlight to the columns
	for i = 0, max_col_height, 1 do
		for column_i, _ in ipairs(columns) do
			local col_start = column_i == 1 and 0 or (column_i - 1) * column_width + ((column_i - 1) * 2)

			if columns[column_i][i] then
				-- highlight headings & one line after it
				if vim.tbl_contains(card_headings, columns[column_i][i]) then
					local lines = vim.api.nvim_buf_get_lines(buf, i + #ascii_header - 1, i + #ascii_header + 1, false)

					-- highlight area around card heading
					vim.api.nvim_buf_add_highlight(
						buf,
						cheatsheet,
						"DefaultFloat",
						i + #ascii_header - 1,
						vim.fn.byteidx(lines[1], col_start),
						vim.fn.byteidx(lines[1], col_start)
							+ column_width
							+ vim.fn.strlen(columns[column_i][i])
							- vim.fn.strdisplaywidth(columns[column_i][i])
					)
					-- highlight card heading & randomize hl groups for colorful colors
					vim.api.nvim_buf_add_highlight(
						buf,
						cheatsheet,
						highlight_groups[math.random(1, #highlight_groups)],
						i + #ascii_header - 1,
						vim.fn.stridx(lines[1], vim.trim(columns[column_i][i]), col_start) - 1,
						vim.fn.stridx(lines[1], vim.trim(columns[column_i][i]), col_start)
							+ vim.fn.strlen(vim.trim(columns[column_i][i]))
							+ 1
					)
					vim.api.nvim_buf_add_highlight(
						buf,
						cheatsheet,
						"DefaultFloat",
						i + #ascii_header,
						vim.fn.byteidx(lines[2], col_start),
						vim.fn.byteidx(lines[2], col_start) + column_width
					)

				-- highlight mappings & one line after it
				elseif string.match(columns[column_i][i], "%s+") ~= columns[column_i][i] then
					local lines = vim.api.nvim_buf_get_lines(buf, i + #ascii_header - 1, i + #ascii_header + 1, false)
					vim.api.nvim_buf_add_highlight(
						buf,
						cheatsheet,
						"DefaultFloat",
						i + #ascii_header - 1,
						vim.fn.stridx(lines[1], columns[column_i][i], col_start),
						vim.fn.stridx(lines[1], columns[column_i][i], col_start) + vim.fn.strlen(columns[column_i][i])
					)
					vim.api.nvim_buf_add_highlight(
						buf,
						cheatsheet,
						"DefaultFloat",
						i + #ascii_header,
						vim.fn.byteidx(lines[2], col_start),
						vim.fn.byteidx(lines[2], col_start) + column_width
					)
				end
			end
		end
	end

	-- set highlights for  ascii header
	for i = 0, #ascii_header - 1, 1 do
		vim.api.nvim_buf_add_highlight(buf, cheatsheet, "ChAsciiHeader", i, 0, -1)
	end

	vim.api.nvim_set_current_buf(buf)

	require("utils.etc").set_cleanbuf_opts("cheatsheet")

	vim.keymap.set("n", "<ESC>", function()
		utils.close_buffer(buf)
	end, { buffer = buf })
end

local M = {}
M.toggle = function()
	if vim.g.cheatsheet_displayed then
		utils.close_buffer()
	else
		cheatsheet_draw()
	end
end

return M
