vim.g.mapleader = [[,]]
vim.g.maplocalleader = [[,]]

require("plugins").init()
require("colors").init()
require("keymaps").init()
require("statusline").init({ excluded = { "NvimTree" } })
