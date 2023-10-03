vim.opt.compatible = false
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.mouse = ""
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
vim.opt.showmode = false
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 4
vim.opt.updatetime = 50
vim.opt.signcolumn = "yes"   -- "auto", "yes", "no", "number"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.listchars= "eol:↵,trail:~,tab:>-,nbsp:␣"

-- vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"
-- vim.g.netrw_preview = true

vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("on")

vim.cmd.colorscheme("sorcerer")
