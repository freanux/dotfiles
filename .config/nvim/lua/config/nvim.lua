vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.mouse = ''
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.wildmode = "longest,list"
vim.opt.clipboard = "unnamedplus"
vim.opt.ttyfast = true
vim.opt.visualbell = false
vim.opt.background = "dark"
vim.opt.cursorlineopt = "number"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.modeline = false
vim.opt.shortmess = "aI"
vim.opt.pastetoggle = "<F10>"
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "

vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
vim.g.netrw_preview = true

vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("on")

vim.cmd.colorscheme("sorcerer")
vim.cmd.hi("CursorLineNr guifg=#f5d442 cterm=bold")
vim.cmd.hi("SignColumn guibg=NONE")

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- ***********************************************
-- **** toggle LSP                            ****
-- ***********************************************
vim.keymap.set("n", "<C-F1>", ":lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>")
vim.keymap.set("i", "<C-F1>", "<ESC>:lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>a")
vim.keymap.set("n", "<S-F1>", ":edit<CR>")
vim.keymap.set("i", "<S-F1>", "<ESC>:edit<CR>a")

-- ***********************************************
-- **** file explorer and window key mappings ****
-- ***********************************************

-- toggle fixed and relative line number
vim.keymap.set("n", "<F3>", ":set relativenumber!<CR>")
vim.keymap.set("i", "<F3>", "<ESC>:set relativenumber!<CR>a")

-- show file explorer
vim.keymap.set("n", "<F4>", vim.cmd.Ex)
vim.keymap.set("i", "<F4>", vim.cmd.Ex)

-- show all buffers side by side
vim.keymap.set("n", "<F5>", ":vert sba<CR>")
vim.keymap.set("i", "<F5>", "<ESC>:vert sba<CR>a")

-- show all buffers one below the other
vim.keymap.set("n", "<F6>", ":hori sba<CR>")
vim.keymap.set("i", "<F6>", "<ESC>:hori sba<CR>a")

-- create new buffer
vim.keymap.set("n", "<F7>", ":enew<CR>")
vim.keymap.set("i", "<F7>", "<ESC>:enew<CR>")

-- zoom selected buffer
vim.keymap.set("n", "<F8>", ":only<CR>")
vim.keymap.set("i", "<F8>", "<ESC>:only<CR>a")

-- close selected buffer
vim.keymap.set("n", "<F9>", ":bd<CR>")
vim.keymap.set("i", "<F9>", "<ESC>:bd<CR>")

-- close all open buffers
vim.keymap.set("n", "<F12>", ":%bd<CR>")
vim.keymap.set("i", "<F12>", "<ESC>:%bd<CR>")

-- switch between buffers
vim.keymap.set("n", "<A-Left>", "<C-w>h")
vim.keymap.set("i", "<A-Left>", "<ESC><C-w>ha")

vim.keymap.set("n", "<A-Right>", "<C-w>l")
vim.keymap.set("i", "<A-Right>", "<ESC><C-w>la")

vim.keymap.set("n", "<A-Down>", "<C-w>j")
vim.keymap.set("i", "<A-Down>", "<ESC><C-w>ja")

vim.keymap.set("n", "<A-Up>", "<C-w>k")
vim.keymap.set("i", "<A-Up>", "<ESC><C-w>ka")
