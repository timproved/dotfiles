vim.opt.number = true         -- display line numbers
vim.opt.relativenumber = true -- display relative line numbers
vim.opt.numberwidth = 2       -- set width of line number column
vim.opt.signcolumn = "yes"    -- always show sign column
vim.opt.wrap = false          -- display lines as single line
vim.opt.scrolloff = 10        -- number of lines to keep above/below cursor
vim.opt.sidescrolloff = 8     -- number of columns to keep to the left/right of cursor

vim.opt.expandtab = true      -- convert tabs to spaces
vim.opt.shiftwidth = 4        -- number of spaces inserted for each indentation level
vim.opt.tabstop = 4           -- number of spaces inserted for tab character
vim.opt.softtabstop = 4       -- number of spaces inserted for <Tab> key
vim.opt.smartindent = true    -- enable smart indentation
vim.opt.breakindent = true    -- enable line breaking indentation
vim.opt.smartindent = true
vim.opt.conceallevel = 1

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "~/.config/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.guicursor = ""

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"
vim.opt.laststatus = 3

-- Searching Behaviors
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true  -- match case if explicitly stated
