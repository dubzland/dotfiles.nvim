vim.g.mapleader = [[,]]
vim.g.maplocalleader = [[,]]

require("dubzland.plugins").init(function()
    require("dubzland.autocmds").init()
    require("dubzland.keymaps").init()
    require("dubzland.options").init()
end)

-- vim: foldmethod=marker:
