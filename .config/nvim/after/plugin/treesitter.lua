local keymaps = require("keymaps")
local utils = require("utils")

local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter.setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		"c",
		"cpp",
		"go",
		"lua",
		"python",
		"ron",
		"rust",
		"toml",
		"tsx",
		"typescript",
		"vimdoc",
		"vim",
	},

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = true,

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = keymaps.treesitter().incremental_selection,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = keymaps.treesitter().textobjects.select,
		},
		move = utils.merge({ enable = true, set_jumps = true }, keymaps.treesitter().textobjects.move),
	},
})
