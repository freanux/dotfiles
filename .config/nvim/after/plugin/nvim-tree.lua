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

vim.keymap.set("n", "<C-F3>", "<cmd>NvimTreeResize -5<CR>")
vim.keymap.set("i", "<C-F3>", "<cmd>NvimTreeResize -5<CR>")

vim.keymap.set("n", "<C-F4>", "<cmd>NvimTreeResize +5<CR>")
vim.keymap.set("i", "<C-F4>", "<cmd>:NvimTreeResize +5<CR>")

vim.keymap.set("n", "<C-S-F4>", vim.cmd.NvimTreeRefresh)
vim.keymap.set("i", "<C-S-F4>", vim.cmd.NvimTreeRefresh)

--[[
--
-- i am too stupid to add parameters on a command. -.-
--
vim.keymap.set("n", "<C-F3>", vim.cmd.NvimTreeResize("-5"))
vim.keymap.set("i", "<C-F3>", vim.cmd.NvimTreeResize("-5"))

vim.keymap.set("n", "<C-F4>", vim.cmd.NvimTreeResize("+5"))
vim.keymap.set("i", "<C-F4>", vim.cmd.NvimTreeResize("+5"))
]]
