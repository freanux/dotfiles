local builtin = require('telescope.builtin')

local wk = require("which-key")
wk.register({
    f = {
        name = "Find",
        f = { builtin.find_files, "Find File" },
        g = { builtin.live_grep, "Live Grep" },
        b = { builtin.buffers, "Find in Buffers" },
        h = { builtin.help_tags, "Find in Help" },
        d = { builtin.diagnostics, "Find in Diagnostics" },
        s = { function() builtin.grep_string({ search = vim.fn.input("Grep> ") }) end, "Grep String" },
    },
    g = {
        name = "Git",
        f = { builtin.git_files, "Git Files" },
        c = { builtin.git_commits, "Git Commits" },
        b = { builtin.git_branches, "Git Branches" },
        s = { builtin.git_status, "Git Status" },
        h = { builtin.git_stashes, "Git Stashes" },
    },
    p = {
        name = "Pickers",
        r = { builtin.registers, "Registers" },
        c = { builtin.commands, "Commands" },
        k = { builtin.keymaps, "Keymaps" },
        f = { builtin.filetypes, "File Types" },
        j = { builtin.jumplist, "Jump List" },
    },
    l = {
        name = "LSP",
        r = { builtin.lsp_references, "References" },
        i = { builtin.lsp_implementations, "Implementations" },
        d = { builtin.lsp_definitions, "Definitions" },
        t = { builtin.lsp_type_definitions, "Type Definitions" },
        g = { builtin.diagnostics, "Diagnostics" },
        s = {
            name = "Symbols",
            w = { builtin.lsp_workspace_symbols, "Workspace Symbols" },
            d = { builtin.lsp_document_symbols, "Document Symbols" },
            y = { builtin.lsp_dynamic_workspace_symbols, "Dynamic Workspace Symbols" },
        },
        c = {
            name = "Calls",
            i = { builtin.lsp_incoming_calls, "Incoming Calls" },
            o = { builtin.lsp_outgoing_calls, "Outgoing Calls" },
        },
    },
}, { prefix = "<leader>"})

vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find in Buffers" })

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
