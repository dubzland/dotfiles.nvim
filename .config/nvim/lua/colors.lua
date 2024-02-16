local utils = require("utils")

local set_hl = vim.api.nvim_set_hl

local M = {}

M.values = function()
	return {
		gui00 = "#" .. vim.g.base16_gui00,
		gui01 = "#" .. vim.g.base16_gui01,
		gui02 = "#" .. vim.g.base16_gui02,
		gui03 = "#" .. vim.g.base16_gui03,
		gui04 = "#" .. vim.g.base16_gui04,
		gui05 = "#" .. vim.g.base16_gui05,
		gui06 = "#" .. vim.g.base16_gui06,
		gui07 = "#" .. vim.g.base16_gui07,
		gui08 = "#" .. vim.g.base16_gui08,
		gui09 = "#" .. vim.g.base16_gui09,
		gui0A = "#" .. vim.g.base16_gui0A,
		gui0B = "#" .. vim.g.base16_gui0B,
		gui0C = "#" .. vim.g.base16_gui0C,
		gui0D = "#" .. vim.g.base16_gui0D,
		gui0E = "#" .. vim.g.base16_gui0E,
		gui0F = "#" .. vim.g.base16_gui0F,
	}
end

M.base16_theme = function()
	return os.getenv("BASE16_THEME")
end

M.neovim_theme = function()
	return "base16-" .. M.base16_theme()
end

M.init = function()
	local current_theme_name = os.getenv("BASE16_THEME")
	local base16_color_scheme = "base16-" .. current_theme_name
	if M.base16_theme() and vim.g.colors_name ~= M.neovim_theme() then
		vim.g.base16colorspace = 256
		ok, _ = pcall(vim.cmd.colorscheme, base16_color_scheme)
		if not ok then
			vim.notify(vim.fn.printf("Colorscheme %s not found.", base16_color_scheme))
		end
	end

	if M.available() then
		-- {{{ Statusline
		set_hl(0, "StatuslineModeNormal", { fg = M.values().gui04, bg = M.values().gui01 })
		set_hl(0, "StatuslineModeInsert", { fg = M.values().gui0B, bg = M.values().guibg })
		set_hl(0, "StatuslineModeVisual", { fg = M.values().gui0A, bg = M.values().guibg })
		set_hl(0, "StatuslineModeReplace", { fg = M.values().gui08, bg = M.values().guibg })
		set_hl(0, "StatuslineModeCmdLine", { fg = M.values().gui0C, bg = M.values().gui02 })
		set_hl(0, "StatuslineModeTerminal", { fg = M.values().gui00, bg = M.values().gui0C })
		set_hl(0, "GitSymbol", { fg = M.values().gui0D, bg = M.values().guibg })
		-- }}}

		if utils.is_available("telescope.builtin") then
			set_hl(0, "TelescopeMatching", { fg = M.values().gui0E })
			set_hl(0, "TelescopeNormal", { fg = M.values().gui06, bg = M.values().gui00 })
			set_hl(0, "TelescopeBorder", { fg = M.values().gui01, bg = M.values().gui01 })
			set_hl(0, "TelescopeTitle", { fg = M.values().gui07, bg = M.values().gui02 })
		end
	end
end

M.available = function()
	return M.base16_theme() and vim.g.colors_name == M.neovim_theme()
end

return M
