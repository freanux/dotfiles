local wk = require("which-key")

wk.register({
    u = { vim.cmd.UndotreeToggle, "Undo Tree" },
}, { prefix = "<leader>" })
