local dap = require("dap")

local widgets = require('dap.ui.widgets')
local frames = widgets.centered_float(widgets.frames)
local scopes = widgets.centered_float(widgets.scopes)
local sessions = widgets.centered_float(widgets.sessions)
local expression = widgets.centered_float(widgets.expression)
local threads = widgets.centered_float(widgets.threads)

local function close_all_dap_widgets()
    frames.close()
    scopes.close()
    sessions.close()
    expression.close()
    threads.close()
end

close_all_dap_widgets()

-- prepare icons --------------------------------------------------------------
vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

-- key bindings ---------------------------------------------------------------
vim.keymap.set("n", "<C-S-Esc>", function() close_all_dap_widgets() end, { desc = "Close All DAP Widgets" })
vim.keymap.set("n", "<C-S-F1>", frames.toggle, { desc = "Frames Toggle" })
vim.keymap.set("n", "<C-S-F2>", scopes.toggle, { desc = "Scopes Toggle" })
vim.keymap.set("n", "<C-S-F3>", threads.toggle, { desc = "Threads Toggle" })
vim.keymap.set("n", "<C-S-F4>", expression.toggle, { desc = "Expression Toggle" })

vim.keymap.set("n", "<C-F5>", dap.continue, { desc = "Start, Continue, Restart Session" })
vim.keymap.set("n", "<C-S-F5>", dap.terminate, { desc = "Terminate Session" })

vim.keymap.set("n", "<C-F8>", dap.repl.toggle, { desc = "REPL Toggle" })

vim.keymap.set("n", "<C-F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<C-F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<C-S-F11>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<C-F10>", dap.step_over, { desc = "Step Over" })

-- WHICH KEY ------------------------------------------------------------------
local wk = require("which-key")
wk.register({
    d = {
        name = "DAP",
        c = { dap.continue, "Start, Continue, Restart Session <CTRL-F5>" },
        t = { dap.terminate, "Terminate Session <CTRL-SHIFT-F5>" },
        o = { dap.repl.toggle, "REPL Toggle <CTRL-F8>" },
        b = { dap.toggle_breakpoint, "Toggle Breakpoint <CTRL-F9>" },
        s = { dap.step_over, "Step Over <CTRL-F10>" },
        p = { dap.step_out, "Step Out <CTRL-SHIFT-F11>" },
        i = { dap.step_into, "Step Into <CTRL-F11>" },
        w = {
            name = "Toggle Widgets",
            c = { function() close_all_dap_widgets() end, "Close All Floats" },
            f = { frames.toggle, "Frames" },
            s = { scopes.toggle, "Scopes" },
            e = { expression.toggle, "Expression" },
            t = { threads.toggle, "Threads" },
            i = { sessions.toggle, "Sessions" },
        },
    },
}, { prefix = "<leader>"})

-- C++  -----------------------------------------------------------------------
dap.adapters.lldb = {
    type = 'executable',
    -- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
    command = '/usr/bin/lldb-vscode-10',
    name = "lldb",
}

dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = true,
    },
}
