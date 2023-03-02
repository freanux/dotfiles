vim.g.mapleader = " "
vim.opt.pastetoggle = "<F10>"

-- ***********************************************
-- **** toggle LSP                            ****
-- ***********************************************
vim.keymap.set("n", "<C-o>", vim.cmd.tabprevious)
vim.keymap.set("n", "<C-p>"	,vim.cmd.tabnext)
vim.keymap.set("n", "<C-t>" ,vim.cmd.tabnew)
vim.keymap.set("n", "<C-c>", vim.cmd.tabclose)
vim.keymap.set("i", "<C-o>", vim.cmd.tabprevious)
vim.keymap.set("i", "<C-p>"	,vim.cmd.tabnext)
vim.keymap.set("i", "<C-t>" ,vim.cmd.tabnew)
vim.keymap.set("i", "<C-c>", vim.cmd.tabclose)

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
