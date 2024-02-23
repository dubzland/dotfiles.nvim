return {
    'tinted-theming/base16-vim',
    config = function(_, opts)
        require("dubzland.config.base16-vim").init(opts)
    end,
}

-- vim: foldmethod=marker:
