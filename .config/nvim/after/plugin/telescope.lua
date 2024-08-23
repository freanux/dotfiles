local builtin = require('telescope.builtin')

local wk = require("which-key")

wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>fb", builtin.buffers, desc = "Find in Buffers" },
    { "<leader>fd", builtin.diagnostics, desc = "Find in Diagnostics" },
    { "<leader>ff", builtin.find_files, desc = "Find File" },
    { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
    { "<leader>fh", builtin.help_tags, desc = "Find in Help" },
    { "<leader>fs", function() builtin.grep_string({ search = vim.fn.input("Grep> ") }) end, desc = "Grep String" },
    { "<leader>g", group = "Git" },
    { "<leader>gb", builtin.git_branches, desc = "Git Branches" },
    { "<leader>gc", builtin.git_commits, desc = "Git Commits" },
    { "<leader>gf", builtin.git_files, desc = "Git Files" },
    { "<leader>gs", builtin.git_status, desc = "Git Status" },
    { "<leader>gh", builtin.git_stashes, desc = "Git Stashes" },
    { "<leader>l", group = "LSP" },
    { "<leader>ld", builtin.lsp_definitions, desc = "Definitions" },
    { "<leader>lg", builtin.diagnostics, desc = "Diagnostics" },
    { "<leader>li", builtin.lsp_implementations, desc = "Implementations" },
    { "<leader>lr", builtin.lsp_references, desc = "References" },
    { "<leader>lt", builtin.lsp_type_definitions, desc = "Type Definitions" },
    { "<leader>lc", group = "Calls" },
    { "<leader>lci", builtin.lsp_incoming_calls, desc = "Incoming Calls" },
    { "<leader>lco", builtin.lsp_outgoing_calls, desc = "Outgoing Calls" },
    { "<leader>ls", group = "Symbols" },
    { "<leader>lsd", builtin.lsp_document_symbols, desc = "Document Symbols" },
    { "<leader>lsw", builtin.lsp_workspace_symbols, desc = "Workspace Symbols" },
    { "<leader>lsy", builtin.lsp_dynamic_workspace_symbols, desc = "Dynamic Workspace Symbols" },
    { "<leader>p", group = "Pickers" },
    { "<leader>pc", builtin.commands, desc = "Commands" },
    { "<leader>pf", builtin.filetypes, desc = "File Types" },
    { "<leader>pj", builtin.jumplist, desc = "Jump List" },
    { "<leader>pk", builtin.keymaps, desc = "Keymaps" },
    { "<leader>pr", builtin.registers, desc = "Registers" },
})

vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find in Buffers" })

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-PageUp>"] = actions.preview_scrolling_up,
                ["<C-PageDown>"] = actions.preview_scrolling_down,
            },
            n = {
                ["<C-PageUp>"] = actions.preview_scrolling_up,
                ["<C-PageDown>"] = actions.preview_scrolling_down,
            },
        },
    },
})
