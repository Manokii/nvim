vim.opt.termguicolors = true -- optionally enable 24-bit colour
vim.g.have_nerd_font = true
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
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.colorcolumn = "80,100"
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
-- vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.cursorline = true
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.lsp.set_log_level("off")
vim.opt.listchars:append({ tab = "  ", precedes = "←", extends = "→", nbsp = "␣", trail = "•" })
vim.opt.list = true
vim.opt.breakindent = true
vim.opt.showbreak = "↳ "

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font"
end
