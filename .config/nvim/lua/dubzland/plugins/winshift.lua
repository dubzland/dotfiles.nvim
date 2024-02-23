return {
    'sindrets/winshift.nvim',
    dependencies = {
        'tinted-theming/base16-vim',
    },
    config = function(_, opts)
        require("dubzland.config.winshift").init(opts)
    end
}

-- vim: foldmethod=marker
