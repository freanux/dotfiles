local builtin = require('telescope.builtin')
local wk = require("which-key")

wk.register({
    f = {
        name = "Find",
        f = { builtin.find_files, "Find File" },
        g = { builtin.live_grep, "Live Grep" },
        b = { builtin.buffers, "Buffers" },
        h = { builtin.help_tags, "Help" },
    },
    g = {
        name = "Grep",
        g = { function() builtin.grep_string({ search = vim.fn.input("Grep> ") }) end, "Grep String" },
    },
}, { prefix = "<leader>" })

local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})
