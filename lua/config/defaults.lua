-- Numbered lines
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation (LazyVim default is 2)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Performance & Responsiveness (default is 200)
vim.opt.updatetime = 50

-- UI Customization
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.wrap = false

-- File Handling & History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Specialized Path Detection
vim.opt.isfname:append("@-@")

-- Clipboard sync with system clipboard
vim.opt.clipboard = "unnamedplus"
