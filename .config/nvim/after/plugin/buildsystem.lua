--[[
    CFLAGS: Extra flags to give to the C compiler.
    CXXFLAGS: Extra flags to give to the C++ compiler.
    CPPFLAGS: Extra flags to give to the C preprocessor and programs that use it (the C and Fortran compilers).
--]]

local Path = require("plenary.path")
local popup = require("plenary.popup")

local Defaults = {
    executable = "",
    args = {},
    GNU = {
        prepare = "autoreconf -i",
        configure_help = "./configure --help",
        configure_params = "",
        configure_debug = "CPPFLAGS=-DDEBUG CFLAGS=\"-g -O0\" CXXFLAGS=\"-g -O0\" ./configure",
        configure_release = "CFLAGS=\"-O3\" CXXFLAGS=\"-O3\" ./configure",
        make_clean = "make clean",
        bear = "bear --",
        make = "make -j`nproc`",
        strip = "strip",
    },
}
Config = Defaults

BS_win_id = nil
BS_bufh = nil

-- local functions ------------------------------------------------------------
local function create_window()
    local width = 60
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    local win_id, win = popup.create(bufnr, {
        title = "Arguments",
        highlight = "ArgumentsWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
    })

    vim.api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:ArgumentsBorder"
    )

    return {
        bufnr = bufnr,
        win_id = win_id,
    }
end

local function is_empty(s)
    return s == nil or s == ''
end

local function exec(command)
    vim.api.nvim_command("!" .. command)
end

local function print(text)
    vim.print(text)
end

local function abort()
    print("abort")
end

local function get_conf_fn()
    return vim.fn.getcwd() .. "/.build.conf"
end

local function read_config()
    return vim.json.decode(Path:new(get_conf_fn()):read())
end

local function save_config(conf)
    Path:new(get_conf_fn()):write(vim.fn.json_encode(conf), "w")
end

local function get_config()
    local ok, conf = pcall(read_config)
    if ok then
        Config = conf
    end
    return ok
end

local function get_menu_items()
    local lines = vim.api.nvim_buf_get_lines(BS_bufh, 0, -1, true)
    local indices = {}

    for _, line in pairs(lines) do
        table.insert(indices, line)
    end

    return indices
end

local function close_window()
    Config.args = get_menu_items()
    save_config(Config)

    vim.api.nvim_win_close(BS_win_id, true)
    BS_win_id = nil
    BS_bufh = nil
end

-- GNU ------------------------------------------------------------------------
local function autoreconf()
    get_config()
    exec(Config.GNU.prepare)
    save_config(Config)
end

local function configure_help()
    get_config()
    exec(Config.GNU.configure_help)
    save_config(Config)
end

local function configure_debug()
    get_config()
    local params = vim.fn.input("Configure Params: ", Config.GNU.configure_params)
    if not is_empty(params) then
        Config.GNU.configure_params = params
        exec(Config.GNU.configure_debug .. " " .. Config.GNU.configure_params)
    else
        print("abort...")
    end
    save_config(Config)
end

local function configure_release()
    get_config()
    local params = vim.fn.input("Configure Params: ", Config.GNU.configure_params)
    if not is_empty(params) then
        Config.GNU.configure_params = params
        exec(Config.GNU.configure_release .. " " .. Config.GNU.configure_params)
    else
        abort()
    end
    save_config(Config)
end

local function make_clean()
    get_config()
    exec(Config.GNU.make_clean)
    save_config(Config)
end

local function make()
    get_config()
    exec(Config.GNU.bear .. " " .. Config.GNU.make)
    save_config(Config)
end

local function strip()
    get_config()
    if is_empty(Config.executable) then
        print("No Executable")
    else
        exec(Config.GNU.strip .. " " .. Config.executable)
    end
    save_config(Config)
end

local function declare_executable()
    get_config()
    local executable = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/" .. Config.executable, "file")
    if not is_empty(executable) then
        Config.executable = vim.fn.fnamemodify(executable, ":t")
    else
        abort()
    end
    save_config(Config)
end

local function toggle_set_args()
    if BS_win_id ~= nil and vim.api.nvim_win_is_valid(BS_win_id) then
        close_window()
        return
    end

    get_config()
    local win_info = create_window()
    BS_win_id = win_info.win_id
    BS_bufh = win_info.bufnr

    vim.api.nvim_win_set_option(BS_win_id, "number", true)
    vim.api.nvim_buf_set_name(BS_bufh, "args-menu")
    vim.api.nvim_buf_set_lines(BS_bufh, 0, #Config.args, false, Config.args)
    vim.api.nvim_buf_set_option(BS_bufh, "buftype", "acwrite")
    vim.api.nvim_buf_set_option(BS_bufh, "bufhidden", "delete")

    vim.api.nvim_buf_set_keymap(BS_bufh, "n", "q", "<Cmd>lua BSFuncs.toggle_set_args()<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(BS_bufh, "n", "<ESC>", "<Cmd>lua BSFuncs.toggle_set_args()<CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(BS_bufh, "n", "<CR>", "<Cmd>lua BSFuncs.toggle_set_args()<CR>", {})
    vim.cmd(
        string.format(
            "autocmd BufModifiedSet <buffer=%s> set nomodified",
            BS_bufh
        )
    )
    vim.cmd("autocmd BufLeave <buffer> ++nested ++once silent lua BSFuncs.toggle_set_args()")
end

BSFuncs = {}
BSFuncs.toggle_set_args = toggle_set_args
BSFuncs.read_config = get_config 

local function bear()
    get_config()
    local bear_command = vim.fn.input("Bear command: ", Config.GNU.bear)
    if not is_empty(bear_command) then
        Config.GNU.bear = bear_command
    else
        abort()
    end
    save_config(Config)
end

local function create_build_conf()
    local ok = pcall(save_config, Config)
    print("Configuration " .. (not ok and "not saved!!!" or "saved"))
end

-- ----------------------------------------------------------------------------
local wk = require("which-key")
wk.register({
    b = {
        name = "Project And Buildsystem",
        a = { autoreconf, "autoreconf -i" },
        c = { make_clean, "make clean" },
        h = { configure_help, "./configure --help" },
        d = { configure_debug, "./configure [DEBUG]" },
        r = { configure_release, "./configure [RELEASE]" },
        b = { make, "make" },
        s = { strip, "strip" },
        t = { bear, "setup bear" },
        l = { get_config, "relog config" },
        u = { declare_executable, "declare executable" },
        v = { toggle_set_args, "set arguments" },
        x = { create_build_conf, "create .build.conf" },
    },
    --c = {
    --    name = "CMake And Other Buildsystems",
    --},
}, { prefix = "<leader>"})

