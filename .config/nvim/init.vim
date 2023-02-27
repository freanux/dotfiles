highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set novisualbell
set background=dark
set cursorlineopt=number
set cursorline
set number
set relativenumber
set nomodeline
set shortmess=aI
set pastetoggle=<f10>
set noshowmode
set nowrap

" ***********************************************
" **** file explorer and window key mappings ****
" ***********************************************

" toggle fixed and relative line number 
map <F3> :set relativenumber!<CR>
imap <F3> <ESC>:set relativenumber!<CR>a

" show file explorer
map <F4> :Ex<CR><C-w>o
imap <F4> <ESC>:Ex<CR><C-w>o

" show all buffers side by side
map <F5> :vert sba<CR>
imap <F5> <ESC>:vert sba<CR>

" show all buffers one below the other
map <F6> :hori sba<CR>
imap <F6> <ESC>:hori sba<CR>

" create new buffer
map <F7> :enew<CR>
imap <F7> <ESC>:enew<CR>

" zoom selected buffer
map <F8> :only<CR>
imap <F8> <ESC>:only<CR>

" close selected buffer
map <F9> :bd<CR>
imap <F9> <ESC>:bd<CR>

" close all open buffers
map <F12> :%bd<CR>
imap <F12> <ESC>:%bd<CR>

" switch between buffers
map <A-Left> <C-w>h
imap <A-Left> <ESC><C-w>ha

map <A-Right> <C-w>l
imap <A-Right> <ESC><C-w>la

map <A-Down> <C-w>j
imap <A-Down> <ESC><C-w>ja

map <A-Up> <C-w>k
imap <A-Up> <ESC><C-w>ka

"***** tmux settings *****"
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" ***********************************************
colorscheme sorcerer 
hi CursorLineNr guifg=#f5d442
hi CursorLineNR cterm=bold
set termguicolors

" ***********************************************
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_preview = 1
let g:airline_powerline_fonts = 1

" ***********************************************
" https://github.com/junegunn/vim-plug/
call plug#begin()
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'feline-nvim/feline.nvim', { 'branch': '0.5-compat' }
    Plug 'neovim/nvim-lspconfig'
call plug#end()

" ***********************************************
lua << EOF
    require('feline').setup()
    require('feline_themes/toufyx2')
EOF
