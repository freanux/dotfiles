local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  "clangd",
  "lua_ls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<PageUp>'] = cmp.mapping.scroll_docs(-15),
  ['<PageDown>'] = cmp.mapping.scroll_docs(15),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})
cmp.setup.buffer { enabled = false }

vim.keymap.set("n", "<C-s>", function() require('cmp').setup.buffer { enabled = false } end, {})
vim.keymap.set("i", "<C-s>", function() require('cmp').setup.buffer { enabled = false } end, {})
vim.keymap.set("n", "<C-x>", function() require('cmp').setup.buffer { enabled = true } end, {})
vim.keymap.set("i", "<C-x>", function() require('cmp').setup.buffer { enabled = true } end, {})

vim.keymap.set("n", "<C-F1>", ":lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>")
vim.keymap.set("i", "<C-F1>", "<ESC>:lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>a")
vim.keymap.set("n", "<S-F1>", ":edit<CR>")
vim.keymap.set("i", "<S-F1>", "<ESC>:edit<CR>a")

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = " ",
        warn = " ",
        hint = " ",
        info = " "
    }
})

lsp.on_attach(function(_, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<Tab>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<S-Tab>", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local wk = require("which-key")
wk.register({
    v = {
        name = "LSP",
        w = { name = "Workspace" },
        c = { name = "Code" },
        r = { name = "Reference" },
    },
}, { prefix = "<leader>" })

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

