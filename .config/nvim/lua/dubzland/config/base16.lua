local base16_config = {}

base16_config.init = function(_)
    local set_theme_path = "$HOME/.config/tinted-theming/set_theme.lua"
    local is_set_theme_file_readable = vim.fn.filereadable(vim.fn.expand(set_theme_path)) == 1 and true or false

    if is_set_theme_file_readable then
        vim.g.base16_background_transparent = 1
        vim.g.base16_colorspace = 256
        vim.cmd("source " .. set_theme_path)
    end
    vim.o.termguicolors = true
end

return base16_config

-- vim: foldmethod=marker
