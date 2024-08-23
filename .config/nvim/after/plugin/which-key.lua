local wk = require("which-key")

wk.setup({
    icons = {
        mappings = false,
    },
})

local function toggle_characters()
    vim.opt.list = not (vim.opt.list:get())
end

local function remove_trailing_characters()
    local save_cursor = vim.fn.getpos(".")
    pcall(function() vim.cmd [[%s/\s\+$//e]] end)
    vim.fn.setpos(".", save_cursor)
end

wk.add({
    { "<leader>t", group = "Trailing Characters" },
    { "<leader>tr", function() remove_trailing_characters() end, desc = "Remove Trailing Characters" },
    { "<leader>tt", function() toggle_characters() end, desc = "Toggle Characters" },
})

vim.o.timeoutlen = 0
