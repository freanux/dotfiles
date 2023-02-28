" ***********************************************
" https://github.com/junegunn/vim-plug/
call plug#begin()
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'feline-nvim/feline.nvim', { 'branch': '0.5-compat' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'mbbill/undotree'
    Plug 'theprimeagen/harpoon'

    " LSP support
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'

    " Autocompletion
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-nvim-lua' 

	" Snippets
	Plug 'L3MON4D3/LuaSnip'
	Plug 'rafamadriz/friendly-snippets'

	" LSP zero
	Plug 'VonHeikemen/lsp-zero.nvim'
call plug#end()

" ***********************************************
function! IsInPasteMode()
    return &paste
endfunction

" ***********************************************
lua << EOF
    require('configs')
EOF
