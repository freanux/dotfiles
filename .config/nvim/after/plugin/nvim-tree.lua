require("nvim-tree").setup({
  view = {
    cursorline = true,
    number = true,
    relativenumber = true,
    width = 40,
  },
})

vim.keymap.set("n", "<F4>", vim.cmd.NvimTreeToggle)
vim.keymap.set("i", "<F4>", vim.cmd.NvimTreeToggle)

vim.keymap.set("n", "<C-F3>", ":NvimTreeResize -5<CR>")
vim.keymap.set("i", "<C-F3>", "<ESC>:NvimTreeResize -5<CR>i")

vim.keymap.set("n", "<C-F4>", ":NvimTreeResize +5<CR>")
vim.keymap.set("i", "<C-F4>", "<ESC>:NvimTreeResize +5<CR>i")

--[[
--
-- i am too stupid to add parameters on a command. -.-
--
vim.keymap.set("n", "<C-F3>", vim.cmd.NvimTreeResize("-5"))
vim.keymap.set("i", "<C-F3>", vim.cmd.NvimTreeResize("-5"))

vim.keymap.set("n", "<C-F4>", vim.cmd.NvimTreeResize("+5"))
vim.keymap.set("i", "<C-F4>", vim.cmd.NvimTreeResize("+5"))
]]
