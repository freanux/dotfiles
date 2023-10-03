local wk = require("which-key")

wk.setup()

local function toggle_characters()
    vim.opt.list = not (vim.opt.list:get())
end

local function remove_trailing_characters()
    local save_cursor = vim.fn.getpos(".")
    pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    vim.fn.setpos(".", save_cursor)
end

wk.register({
t = {
    name = "Trailing Characters",
        t = { function() toggle_characters() end, "Toggle Characters" },
        r = { function() remove_trailing_characters() end, "Remove Trailing Characters" },
    },
}, { prefix = "<leader>"})

vim.o.timeoutlen = 0
