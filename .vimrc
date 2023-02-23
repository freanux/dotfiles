highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE
set ignorecase
nnoremap <CR> :noh<CR><C-L><C-M>
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bprevious<CR>
set autowrite
set nobackup
set nowritebackup
set nocompatible
set showmode
set report=0
set backspace=2
set noerrorbells
set helpheight=20
set noinsertmode
set shortmess=aI
set cpoptions=aABceFsJWy
set hidden
set laststatus=2
set lazyredraw
set modeline
set modelines=5
set path=.,~/
set ruler
set noshowmode
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar
set history=50
set showcmd
set startofline
set nosplitbelow
set ttybuiltin
set ttyscroll=999
set viminfo='20,"\50
set novisualbell
set t_vb=
set wrapmargin=0
fu! Options()
	let opt=""
	if &ai|   let opt=opt." ai"   |endif
	if &et|   let opt=opt." et"   |endif
	if &hls|  let opt=opt." hls"  |endif
	if &nu|   let opt=opt." nu"   |endif
	if &ek|   let opt=opt." ek"   |endif
	if &list| let opt=opt." list" |endif
	if &paste|let opt=opt." paste"|endif
	if &shiftwidth!=8|let opt=opt." sw=".&shiftwidth|endif
	let opt=opt." tw=".&tw
	"let opt=opt."\[".&lines.",".&columns."\]"
	return opt
endf
set nowrap
"set joinspaces
set background=dark
set tabstop=4
set shiftwidth=4
"set textwidth=80 " Gilt nicht bei eMail und News, siehe unten
"set digraph
set esckeys
set formatoptions=cqrto
set noshowmatch
set hlsearch
set incsearch
set noignorecase
"set iskeyword=@,48-57,_,192-255,-,.,@-@
set magic
if has("syntax")
	syntax on
endif
set comments=b:#,b:\",:%,fb:-,n:>,n:),b:\|
"set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
if has("autocmd")
	au FileType mail set tw=65
	au FileType mail set expandtab
	au FileType mail set tabstop=3
	au FileType news set tw=65
	au FileType news set expandtab
	au FileType news set tabstop=3
	au FileType c	 set cindent
	au FileType c	 set tabstop=4
	au FileType c	 set shiftwidth=4
	au FileType c    set expandtab
	au FileType cpp	 set cindent
	au FileType cpp	 set tabstop=4
	au FileType cpp	 set shiftwidth=4
	au FileType cpp	 set expandtab

	"au FileType mail let @"="X-Editor: Vim-6.00 http://www.vim.org\n"|exe 'norm1G}""P'
endif
map ,kqs G?^> *-- $<CR>d/^-- $/<C-M>
"if has("autocmd")
"	autocmd BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L
"endif
map Q gq
map ,hexedit :%!xxd<CR>
nmap 2HTML :so $VIMRUNTIME/syntax/2html.vim
vmap ,dr :!tr A-Za-z N-ZA-Mn-za-m
map ,cs 1G/^Subject: <CR>yypIX-Old-<ESC>-W
map ,mlu 1G}OPriority: urgent<ESC>
map ,hi 1G}oHi!<CR><ESC>
map ,he 1G}oHello, again!<CR><ESC>
map ,ha 1G}oHallo!<CR><ESC>
map ;HI G/^\* /e+1<CR>ye1G}oHi, !<ESC>Po<ESC>

map ;HA G/^\* /e+1<CR>ye1G}oHallo, !<ESC>Po<ESC>
vmap ,trimm c[...]<ESC>
imap QC_ ,------[]<CR><CR>`------[]<UP>\| 
vmap ,kpq :s/^> *[a-zA-Z]*>/> >/<C-M>
set pastetoggle=<f10>
set whichwrap=<,>,h,l
set wildchar=<TAB>
cnoremap <C-A>      <Home>
cnoremap <C-B>      <Left>
cnoremap <C-E>      <End>
cnoremap <C-F>      <Right>
cnoremap <C-N>      <End>
cnoremap <C-P>      <Up>
cnoremap <ESC>b     <S-Left>
cnoremap <ESC><C-B> <S-Left>
cnoremap <ESC>f     <S-Right>
cnoremap <ESC><C-F> <S-Right>
cnoremap <ESC><C-H> <C-W>
cnoremap <ESC>[D <Left>
cnoremap <ESC>[C <Right>
map <ESC>[A <Up>
map <ESC>[B <Down>
map <ESC>[C <Right>
map <ESC>[D <Left>
imap <ESC>[A <Up>
imap <ESC>[B <Down>
imap <ESC>[C <Right>
imap <ESC>[D <Left>
set notimeout
set smartindent
set smarttab
set autoindent

" Relative or absolute number lines
map <C-Esc> :set nosmartindent<CR>:set noautoindent<CR>
map <F3> :set relativenumber!<CR>
"map <F5> :1,$s/\t/    /g<CR>
set completeopt=menu,menuone
set dir=~/.vim/tmp
command C let @/=""

let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

" tab navigation like firefox
nnoremap <C-o>	:tabprevious<CR>
nnoremap <C-p>	:tabnext<CR>
nnoremap <C-t>	:tabnew<CR>
inoremap <c-o>	<Esc>:tabprevious<CR>i
inoremap <C-p>	<Esc>:tabnext<CR>i
inoremap <C-t>	<Esc>:tabnew<CR>

colorscheme sorcerer
"***** tmux settings *****"
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
set undofile
set undodir=~/.vim/undo
call pathogen#infect()
filetype off
syntax on
filetype plugin indent on
set foldmethod=syntax
set foldlevel=99
map <F2> za
map <F8> :call g:ClangUpdateQuickFix()<CR>
hi CursorLineNr guifg=#f5d442
set cursorline
set cursorlineopt=number
hi CursorLineNR cterm=bold
set number
set relativenumber
set nomodeline
