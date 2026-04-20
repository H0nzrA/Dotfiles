vim.cmd("let g:netrw_liststyle = 3")
-- vim.g.python3_host_prog = "/usr/bin/python"
vim.g.python3_host_prog = vim.fn.exepath("python3")
local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Tabulation and Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.autoindent = true

opt.wrap = false

-- Search setting
opt.ignorecase = true
opt.smartcase = false -- true = If mixed case in search, assumes 'case-sensitive'

-- Cursor line
opt.cursorline = true

-- Termguicolors (true color terminal must use)
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard (use system clipboard as default register)
opt.clipboard:append("unnamedplus")


-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Backup file
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.hidden = true

