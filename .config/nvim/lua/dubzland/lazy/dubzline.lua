return {
    "dubzland/dubzline.nvim",
    dependencies = {
        'tinted-theming/base16-vim',
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
    },
    config = function(_, opts)
        require("dubzland.config.dubzline").init(opts)
    end,
}

-- vim: foldmethod=marker
