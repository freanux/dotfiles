" ***********************************************
" https://github.com/junegunn/vim-plug/
call plug#begin()
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'feline-nvim/feline.nvim', { 'branch': '0.5-compat' }
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'mbbill/undotree'
    Plug 'theprimeagen/harpoon'
    Plug 'folke/which-key.nvim'
    Plug 's1n7ax/nvim-window-picker'
    Plug 'sudormrfbin/cheatsheet.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug '/home/flynn/Programming/procurator.nvim'

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

    " DAP debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'ldelossa/nvim-dap-projects'
    Plug 'nvim-neotest/nvim-nio'
call plug#end()

" ***********************************************
lua require('startup')
