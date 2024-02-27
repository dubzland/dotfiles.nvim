return {
    'tinted-theming/base16-vim',
    config = function(_, opts)
        require("dubzland.config.base16").init(opts)
    end,
}

-- vim: foldmethod=marker:
