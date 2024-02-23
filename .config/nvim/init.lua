vim.g.mapleader = [[,]]
vim.g.maplocalleader = [[,]]

-- {{{ Initialize lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "plugins",
	change_detection = { notify = false }
})
-- }}}

require("statusline").init({ excluded = { "NvimTree" } })

-- vim: set sts=4 sw=4 ts=4 noet foldmethod=marker:
