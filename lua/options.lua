-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.laststatus = 3 -- global statusline

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Preferences
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80,100"

-- Code actions
-- vim.g.code_action_menu_show_details = false
-- vim.g.code_action_menu_show_diff = false
-- vim.g.code_action_menu_show_action_kind = false

-- Scroll
vim.opt.scrolloff = 10
-- vim.opt.wrap = true
vim.opt.linebreak = true
vim.lsp.set_log_level("off")

-- Update some characters
vim.opt.listchars:append({ tab = "  ", precedes = "←", extends = "→", nbsp = "•", trail = "•" })
-- vim.opt.listchars:append({ precedes = "←", extends = "→", nbsp = "•", trail = "•" })
vim.opt.list = true

-- Linebreaks and indents
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "
