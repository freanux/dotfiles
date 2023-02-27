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
vim.opt.wildmode = 'longest,list'
vim.opt.clipboard = 'unnamedplus'
vim.opt.ttyfast = true
vim.opt.visualbell = false
vim.opt.background = 'dark'
vim.opt.cursorlineopt = 'number'
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.modeline = false
vim.opt.shortmess = 'aI'
vim.opt.pastetoggle = '<F10>'
-- vim.opt.showmode = false
vim.opt.wrap = false

vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax on'
vim.cmd 'colorscheme sorcerer'
vim.cmd 'hi CursorLineNr guifg=#f5d442 cterm=bold'

-- ***********************************************
-- **** file explorer and window key mappings ****
-- ***********************************************

-- toggle fixed and relative line number
vim.cmd 'map <F3> :set relativenumber!<CR>'
vim.cmd 'imap <F3> <ESC>:set relativenumber!<CR>a'

-- show file explorer
vim.cmd 'map <F4> :Ex<CR><C-w>o'
vim.cmd 'imap <F4> <ESC>:Ex<CR><C-w>o'

-- show all buffers side by side
vim.cmd 'map <F5> :vert sba<CR>'
vim.cmd 'imap <F5> <ESC>:vert sba<CR>'

-- show all buffers one below the other
vim.cmd 'map <F6> :hori sba<CR>'
vim.cmd 'imap <F6> <ESC>:hori sba<CR>'

-- create new buffer
vim.cmd 'map <F7> :enew<CR>'
vim.cmd 'imap <F7> <ESC>:enew<CR>'

-- zoom selected buffer
vim.cmd 'map <F8> :only<CR>'
vim.cmd 'imap <F8> <ESC>:only<CR>'

-- close selected buffer
vim.cmd 'map <F9> :bd<CR>'
vim.cmd 'imap <F9> <ESC>:bd<CR>'

-- close all open buffers
vim.cmd 'map <F12> :%bd<CR>'
vim.cmd 'imap <F12> <ESC>:%bd<CR>'

-- switch between buffers
vim.cmd 'map <A-Left> <C-w>h'
vim.cmd 'imap <A-Left> <ESC><C-w>ha'

vim.cmd 'map <A-Right> <C-w>l'
vim.cmd 'imap <A-Right> <ESC><C-w>la'

vim.cmd 'map <A-Down> <C-w>j'
vim.cmd 'imap <A-Down> <ESC><C-w>ja'

vim.cmd 'map <A-Up> <C-w>k'
vim.cmd 'imap <A-Up> <ESC><C-w>ka'

