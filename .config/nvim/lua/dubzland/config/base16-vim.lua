local base16_config = {}

base16_config.init = function(_)
    local current_theme_name = os.getenv("BASE16_THEME")
    local base16_color_scheme = "base16-" .. current_theme_name
    if current_theme_name and vim.g.colors_name ~= base16_color_scheme then
        vim.g.base16_background_transparent = 1
        vim.g.base16colorspace = 256

        local ok, _ = pcall(vim.cmd.colorscheme, base16_color_scheme)
        if not ok then
            vim.notify(vim.fn.printf("Colorscheme %s not found.", base16_color_scheme))
        end
    end
    vim.o.termguicolors = true
end

return base16_config

-- vim: foldmethod=marker
