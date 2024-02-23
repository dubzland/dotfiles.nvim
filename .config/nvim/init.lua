vim.g.mapleader = [[,]]
vim.g.maplocalleader = [[,]]

require("dubzland.plugins").init(function()
    require("dubzland.statusline").init({ excluded = { "NvimTree" } })
    require("dubzland.options").init()
    require("dubzland.autocmds").init()
    require("dubzland.keymaps").init()
end)

-- vim: foldmethod=marker:
