local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local wk = require("which-key")

wk.register({
    a = { mark.add_file, "Harpoon: Add File" },
    q = { ui.toggle_quick_menu, "Harpoon: Open Menu" },
    n = { ui.nav_next, "Harpoon: Jump Next" },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end, { desc = "Harpoon: Jump To 1" })
vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end, { desc = "Harpoon: Jump To 2" })
vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end, { desc = "Harpoon: Jump To 3" })
vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end, { desc = "Harpoon: Jump To 4" })
