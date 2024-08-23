local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local wk = require("which-key")

wk.add({
    { "<leader>a", mark.add_file, desc = "Harpoon: Add File" },
    { "<leader>n", ui.nav_next, desc = "Harpoon: Jump Next" },
    { "<leader>q", ui.toggle_quick_menu, desc = "Harpoon: Open Menu" },
})

vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end, { desc = "Harpoon: Jump To 1" })
vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end, { desc = "Harpoon: Jump To 2" })
vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end, { desc = "Harpoon: Jump To 3" })
vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end, { desc = "Harpoon: Jump To 4" })
