return {
    'prichrd/netrw.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function(_, opts)
        require("dubzland.config.netrw").init(opts)
    end,
}

-- vim: foldmethod=marker
