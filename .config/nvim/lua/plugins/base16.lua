return {
    'tinted-theming/base16-vim',
    config = function()
        local current_theme_name = os.getenv("BASE16_THEME")
        local base16_color_scheme = "base16-" .. current_theme_name
        if current_theme_name and vim.g.colors_name ~= base16_color_scheme then
            vim.g.base16colorspace = 256

            local ok, _ = pcall(vim.cmd.colorscheme, base16_color_scheme)
            if not ok then
                vim.notify(vim.fn.printf("Colorscheme %s not found.", base16_color_scheme))
            end
        end
        vim.o.termguicolors = true


        local colors = require("colors").values

        -- {{{ Statusline
        vim.api.nvim_set_hl(0, "StatuslineModeNormal", { fg = colors.gui04, bg = colors.gui01 })
        vim.api.nvim_set_hl(0, "StatuslineModeInsert", { fg = colors.gui0B, bg = colors.guibg })
        vim.api.nvim_set_hl(0, "StatuslineModeVisual", { fg = colors.gui0A, bg = colors.guibg })
        vim.api.nvim_set_hl(0, "StatuslineModeReplace", { fg = colors.gui08, bg = colors.guibg })
        vim.api.nvim_set_hl(0, "StatuslineModeCmdLine", { fg = colors.gui0C, bg = colors.gui02 })
        vim.api.nvim_set_hl(0, "StatuslineModeTerminal", { fg = colors.gui00, bg = colors.gui0C })
        vim.api.nvim_set_hl(0, "GitSymbol", { fg = colors.gui0D, bg = colors.guibg })
        -- }}}
    end,
}
