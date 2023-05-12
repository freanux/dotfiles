P = function(v)
    print(vim.inspect(v))
    return v
end

local RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
