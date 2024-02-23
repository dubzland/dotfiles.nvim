return {
    'folke/neodev.nvim',
    config = function(_, opts)
        require("dubzland.config.neodev").init(opts)
    end,
}

-- vim: foldmethod=marker
