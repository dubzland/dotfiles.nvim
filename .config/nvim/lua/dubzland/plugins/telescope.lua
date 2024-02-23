return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        'tinted-theming/base16-vim',
    },
    config = function(_, opts)
        require("dubzland.config.telescope").init(opts)
    end,
}

-- vim: foldmethod=marker
