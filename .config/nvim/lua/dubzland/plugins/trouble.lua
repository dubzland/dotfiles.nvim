return {
    'folke/trouble.nvim',
    config = function(_, opts)
        require("dubzland.config.trouble").init(opts)
    end,
}

-- vim: foldmethod=marker
