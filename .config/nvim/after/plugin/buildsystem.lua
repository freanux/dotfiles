--[[
    CFLAGS: Extra flags to give to the C compiler.
    CXXFLAGS: Extra flags to give to the C++ compiler.
    CPPFLAGS: Extra flags to give to the C preprocessor and programs that use it (the C and Fortran compilers).
--]]

local Path = require("plenary.path")

local Defaults = {
    GNU = {
        prepare = "autoreconf -i",
        configure_help = "./configure --help",
        configure_params = "",
        configure_debug = "CPPFLAGS=-DDEBUG CFLAGS=\"-g -O0\" CXXFLAGS=\"-g -O0\" ./configure",
        configure_release = "CFLAGS=\"-O3\" CXXFLAGS=\"-O3\" ./configure",
        make_clean = "make clean",
        make = "make -j`nproc`",
        strip_filename = "",
        strip = "strip",
    },
}

Config = Defaults

local function is_empty(s)
    return s == nil or s == ''
end

local function exec(command)
    vim.api.nvim_command("!" .. command)
end

local function print(text)
    vim.print(text)
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
end

-- GNU ------------------------------------------------------------------------
local function autoreconf()
    get_config()
    exec(Config.GNU.prepare)
end

local function configure_help()
    get_config()
    exec(Config.GNU.configure_help)
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
end

local function configure_release()
    get_config()
    local params = vim.fn.input("Configure Params: ", Config.GNU.configure_params)
    if not is_empty(params) then
        Config.GNU.configure_params = params
        exec(Config.GNU.configure_release .. " " .. Config.GNU.configure_params)
    else
        print("abort...")
    end
end

local function make_clean()
    get_config()
    exec(Config.GNU.make_clean)
end

local function make()
    get_config()
    exec(Config.GNU.make)
end

local function strip()
    get_config()
    local filename = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/" .. Config.GNU.strip_filename, "file")
    if not is_empty(filename) then
        Config.GNU.strip_filename = vim.fn.fnamemodify(filename, ":t")
        exec(Config.GNU.strip .. " " .. vim.fn.getcwd() .. "/" .. Config.GNU.strip_filename)
    else
        print("abort...")
    end
end

local function create_build_conf()
    local ok = pcall(save_config, Config)
    print("Configuration " .. (not ok and "not saved!!!" or "saved"))
end

-- ----------------------------------------------------------------------------
local wk = require("which-key")
wk.register({
    b = {
        name = "Buildsystem",
        a = { autoreconf, "autoreconf -i" },
        c = { make_clean, "make clean" },
        h = { configure_help, "./configure --help" },
        d = { configure_debug, "./configure [DEBUG]" },
        r = { configure_release, "./configure [RELEASE]" },
        b = { make, "make" },
        s = { strip, "strip" },
        x = { create_build_conf, "create .build.conf" },
    },
    --c = {
    --    name = "CMake And Other Buildsystems",
    --},
}, { prefix = "<leader>"})

