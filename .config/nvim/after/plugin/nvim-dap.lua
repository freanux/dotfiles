local dap = require("dap")
local widgets = require("dap.ui.widgets")

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

local function is_empty(s)
    return s == nil or s == ''
end

-- DAP UI ---------------------------------------------------------------------
local dapui = require("dapui")

dapui.setup(
  {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
      elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 80
    }, {
      elements = {
        {
          id = "repl",
          size = 1.0
        },
      },
      position = "bottom",
      size = 10
    } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "<Space>",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
)

local opts = { reset = true }

vim.keymap.set("n", "<C-F12>", function() dapui.toggle(opts) end, { desc = "Toggle DAP UI"  })
vim.keymap.set("n", "<C-S-F12>", function() dapui.toggle(opts) dapui.toggle(opts) end, { desc = "Toggle DAP UI"  })

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open(opts) end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close(opts) end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close(opts) end

-- jump to element ------------------------------------------------------------
local function jump_to_element(element)
  local visible_wins = vim.api.nvim_tabpage_list_wins(0)

  for _, win in ipairs(visible_wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == element then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  vim.notify(("element '%s' not found"):format(element), vim.log.levels.WARN)
end

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
vim.keymap.set("n", "<C-S-F4>", dapui.eval, { desc = "Evaluate Expression Under Cursor" })

vim.keymap.set("n", "<C-F5>", dap.continue, { desc = "Start, Continue, Restart Session" })
vim.keymap.set("n", "<C-S-F5>", dap.terminate, { desc = "Terminate Session" })

vim.keymap.set("n", "<C-F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<C-S-F9>", dap.clear_breakpoints, { desc = "Delete All Breakpoints" })
vim.keymap.set("n", "<C-F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<C-S-F11>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<C-F10>", dap.step_over, { desc = "Step Over" })

vim.keymap.set("n", "g1", function() jump_to_element("dapui_watches") end, { desc = "Debug: Jump To Watches" })
vim.keymap.set("n", "g2", function() jump_to_element("dapui_stacks") end, { desc = "Debug: Jump To Stacks" })
vim.keymap.set("n", "g3", function() jump_to_element("dapui_breakpoints") end, { desc = "Debug: Jump To Breakpoints" })
vim.keymap.set("n", "g4", function() jump_to_element("dapui_scopes") end, { desc = "Debug: Jump To Scopes" })
vim.keymap.set("n", "g5", function() jump_to_element("dap-repl") end, { desc = "Debug: Jump To REPL" })

-- WHICH KEY ------------------------------------------------------------------
local wk = require("which-key")
wk.register({
    d = {
        name = "Debugging",
        c = { dap.continue, "Start, Continue, Restart Session <CTRL-F5>" },
        t = { dap.terminate, "Terminate Session <CTRL-SHIFT-F5>" },
        o = { dap.repl.toggle, "REPL Toggle <CTRL-F8>" },
        b = { dap.toggle_breakpoint, "Toggle Breakpoint <CTRL-F9>" },
        d = { dap.clear_breakpoints, "Delete All Breakpoints <CTRL-SHIFT-F9>" },
        s = { dap.step_over, "Step Over <CTRL-F10>" },
        p = { dap.step_out, "Step Out <CTRL-SHIFT-F11>" },
        i = { dap.step_into, "Step Into <CTRL-F11>" },
        u = { dapui.toggle, "Toggle DAP UI <CTRL-F12>" },
        w = {
            name = "Toggle Widgets",
            c = { function() close_all_dap_widgets() end, "Close All Floats" },
            f = { frames.toggle, "Frames" },
            s = { scopes.toggle, "Scopes" },
            e = { expression.toggle, "Expression" },
            t = { threads.toggle, "Threads" },
            i = { sessions.toggle, "Sessions" },
        },
        x = {
            name = "Examine/Jump Call Stack",
            u = { dap.up, "Jump Up" },
            d = { dap.down, "Jump Down" },
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

dap.adapters.cppdbg = {
    type = "executable",
    command = "/usr/bin/gdb",
    name = "cppdbg",
    id = "cppdbg",
    MIMode = "gdb",
}

dap.configurations.cpp = {
    {
      name = "Launch LLDB",
      type = "lldb",
      request = "launch",
      program = function()
        BSFuncs.read_config()
        local filename = is_empty(Config.executable) and vim.fn.fnamemodify(vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file"), ":t") or Config.executable
        return vim.fn.getcwd() .. "/" .. filename
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = function()
        BSFuncs.read_config()
        return Config.stop_on_entry
      end,
      args = function()
        BSFuncs.read_config()
        return Config.args
      end,
      runInTerminal = true,
    },
}
