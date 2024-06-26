vim.g.mapleader = " "
vim.keymap.set("n", "q", "<Nop>")    -- turn off recording

-- ***********************************************
-- **** tab keys                              ****
-- ***********************************************
vim.keymap.set("n", "<A-o>", vim.cmd.tabprevious)
vim.keymap.set("n", "<A-p>", vim.cmd.tabnext)
vim.keymap.set("n", "<A-t>", vim.cmd.tabnew)
vim.keymap.set("n", "<A-c>", vim.cmd.tabclose)
vim.keymap.set("i", "<A-o>", vim.cmd.tabprevious)
vim.keymap.set("i", "<A-p>", vim.cmd.tabnext)
vim.keymap.set("i", "<A-t>", vim.cmd.tabnew)
vim.keymap.set("i", "<A-c>", vim.cmd.tabclose)

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
