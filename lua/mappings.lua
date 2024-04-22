-- NOTE:
-- description should start with category name (eg: Git)
-- if you want to omit the keymap from cheatsheet, start desc with _

local map = vim.keymap.set
local keymap = vim.api.nvim_set_keymap
local telescope = require("utils.telescope")
local gitsigns = require("utils.gitsigns")
local term = require("utils.term")
local etc = require("utils.etc")
local cheatsheet = require("utils.cheatsheet")

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Utils Line number toggle" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Utils Relative number toggle" })
map("n", ";", ":", { desc = "_CMD mode" })
map("v", "p", "P") -- prevents replacing the register when pasting on visual mode
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "_Clear highlights" })

-- Allow navigating vertically in wrapped lines
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

map("i", "<C-b>", "<ESC>^i", { desc = "_Move Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "_Move End of line" })
map("i", "<C-h>", "<Left>", { desc = "_Move Left" })
map("i", "<C-l>", "<Right>", { desc = "_Move Right" })
map("i", "<C-j>", "<Down>", { desc = "_Move Down" })
map("i", "<C-k>", "<Up>", { desc = "_Move Up" })

-- Navigation
map("i", "jj", "<ESC>", { desc = "Navigation Escape insert mode" })
map("n", "<C-d>", "<C-d>zz", { desc = "Navigation Jump half page down and center the cursor" })
map("n", "<C-u>", "<C-u>zz", { desc = "Navigation Jump half page up and center the cursor" })
map("n", "n", "nzzzv", { desc = "Navigation Next in search, center the page and unfold" })
map("n", "N", "Nzzzv", { desc = "Navigation Previous in search, center the page and unfold" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Navigation Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Navigation Move selection up" })
map("n", "<leader>ch", cheatsheet.toggle, { desc = "Utils Cheatsheet" })

-- Navigating between windows
map("n", "<C-h>", "<C-w>h", { desc = "WindowNavigation Switch to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "WindowNavigation Switch to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "WindowNavigation Switch to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "WindowNavigation Switch to top window" })

-- LSP
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp Floating Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp Next Diagnostic" })
map("n", "gd", telescope.lsp_definitions, { desc = "LSP Goto Definition" })
map("n", "gr", telescope.lsp_references, { desc = "LSP Goto References" })
map("n", "gI", telescope.lsp_implementations, { desc = "LSP Goto Implementation" })
map("n", "<leader>D", telescope.lsp_type_definitions, { desc = "LSP Type Definition" })
map("n", "<leader>ds", telescope.lsp_document_symbols, { desc = "LSP Document Symbols" })
map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Documentation" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Goto Declaration" })
map("n", "<leader>ll", etc.lint, { desc = "Utils Lint current file" })
map("n", "<leader>fm", etc.format, { desc = "Utils Format Files" })

-- Comment
map("n", "<leader>/", etc.toggle_comment_line, { desc = " Toggle" })
map("v", "<leader>/", etc.toggle_comment_visual, { desc = "Comment Toggle" })

-- Nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "FileTree Toggle File Tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "FileTree Focus/Open File Tree" })

-- Telescope
map("n", "<leader>fg", telescope.live_grep, { desc = "FuzzyFind Find with Live Grep" })
map("n", "<leader>fh", telescope.help_tags, { desc = "FuzzyFind Find Help" })
map("n", "<leader>fo", telescope.oldfiles, { desc = "FuzzyFind Find Old files" })
map("n", "<leader>fs", telescope.lsp_document_symbols, { desc = "FuzzyFind Find [R]eferences" })
map("n", "<leader>fk", telescope.keymaps, { desc = "FuzzyFind Find Keymaps" })
map("n", "<leader>fb", telescope.builtin, { desc = "FuzzyFind Find Telescope [B]uiltin" })
map("n", "<leader>fw", telescope.grep_string, { desc = "FuzzyFind Find current [W]ord" })
map("n", "<leader>fd", telescope.diagnostics, { desc = "FuzzyFind Find Diagnostics" })
map("n", "<leader>fr", telescope.resume, { desc = "FuzzyFind Find Resume" })
map("n", "<leader><leader>", telescope.buffers, { desc = "FuzzyFind Find existing buffers" })
map("n", "<leader>gm", telescope.git_commits, { desc = "Git Git Commits" })
map("n", "<leader>gs", telescope.git_status, { desc = "Git Git [S]tatus" })
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", { desc = "FuzzyFind Find Files" })
map("n", "<leader>f/", telescope.fuzzy, { desc = "FuzzyFind Fuzzily search in current buffer" })
map("n", "<leader>s/", telescope.fuzzy_all_buffers, { desc = "FuzzyFind Search in Open Files" })
map("n", "<leader>fn", telescope.nvim_settings, { desc = "FuzzyFind Find Neovim files" })

-- Term
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })
-- map({ "n", "t" }, "<A-v>", term.toggle_vertical, { desc = "Terminal Toggleable vertical term" })
-- map({ "n", "t" }, "<A-h>", term.toggle_horizontal, { desc = "Terminal New horizontal term" })
-- map({ "n", "t" }, "<A-i>", term.toggle_float, { desc = "Terminal Toggle Floating term" })
term.toggle_map({
	{ keymap = "<A-i>", desc = "Terminal Toggle Floating Term Main", id = "Main" },
	{ keymap = "<A-0>", desc = "Terminal Toggle Floating Term 1", id = "0" },
	{ keymap = "<A-9>", desc = "Terminal Toggle Floating Term 2", id = "9" },
	{ keymap = "<A-8>", desc = "Terminal Toggle Floating Term 3", id = "8" },
})
map("t", "<ESC>", term.close, { desc = "Terminal Close term in terminal mode" })

-- Whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })
map("n", "<leader>wk", etc.whichkey_lookup, { desc = "Whichkey query lookup" })

-- Gitsigns
map("n", "]c", gitsigns.next_hunk, { desc = "Git Jump to next git change" })
map("n", "[c", gitsigns.prev_hunk, { desc = "Git Jump to previous git change" })
map("v", "<leader>hs", gitsigns.stage_selected_hunk, { desc = "Git Stage hunk" })
map("v", "<leader>hr", gitsigns.reset_selected_hunk, { desc = "Git Reset hunk" })
map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git Stage hunk" })
map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git Reset hunk" })
map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git Stage buffer" })
map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git Undo stage hunk" })
map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git Reset buffer" })
map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git Preview hunk" })
map("n", "<leader>hb", gitsigns.blame_line, { desc = "Git Blame line" })
map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Diff against index" })
map("n", "<leader>hD", gitsigns.diff_last_commit, { desc = "Git Diff against last commit" })
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git Toggle git show blame line" })
map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "Git Toggle git show Deleted" })
