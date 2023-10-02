local lsp = require("lsp-zero")

lsp.preset("recommended")

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd', 'lua_ls'},
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "P", "R" }
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup.buffer { enabled = false }

vim.keymap.set({"n", "i"}, "<C-s>", function() require('cmp').setup.buffer { enabled = false } end, {})
vim.keymap.set({"n", "i"}, "<C-x>", function() require('cmp').setup.buffer { enabled = true } end, {})

local function turn_lsp_off()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.print("LSP off")
end

vim.keymap.set({"n", "i"}, "<C-F1>", turn_lsp_off, { desc = "Turn LSP Off For Current Buffer" })
vim.keymap.set("n", "<S-F1>", ":edit<CR>", { desc = "Reread and Turn LSP On" })
vim.keymap.set("i", "<S-F1>", "<ESC>:edit<CR>a", { desc = "Reread and Turn LSP On" })

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<PageUp>'] = cmp.mapping.scroll_docs(-15),
        ['<PageDown>'] = cmp.mapping.scroll_docs(15),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
})

lsp.set_sign_icons({
    error = " ",
    warn = " ",
    hint = " ",
    info = " "
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = bufnr, remap = false, desc = "Jump Definition" })
  vim.keymap.set("n", "gb", "<C-o>", { buffer = bufnr, remap = false, desc = "Jump Back" })
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<Tab>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<S-Tab>", function() vim.diagnostic.goto_prev() end, opts)
  --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

