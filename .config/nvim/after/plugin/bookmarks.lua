local bm = require "bookmarks"
bm.setup()

local wk = require("which-key")
wk.add({
    { "<leader>m", group = "Bookmarks" },
    { "<leader>mm", bm.bookmark_toggle, desc = "add or remove bookmark at current line" },
    { "<leader>mi", bm.bookmark_ann, desc = "add or edit mark annotation at current line" },
    { "<leader>mc", bm.bookmark_clean, desc = "clean all marks in local buffer" },
    { "<leader>mn", bm.bookmark_next, desc = "jump to next mark in local buffer" },
    { "<leader>mp", bm.bookmark_prev, desc = "jump to previous mark in local buffer" },
    { "<leader>ml", bm.bookmark_list, desc = "show marked file list in quickfix window" },
    { "<leader>mx", bm.bookmark_clear_all, desc = "removes all bookmarks" },
})
