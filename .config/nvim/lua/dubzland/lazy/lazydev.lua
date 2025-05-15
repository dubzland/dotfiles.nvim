return {
    'folke/lazydev.nvim',
    ft = "lua",
    opts = function(_, opts)
        require("dubzland.config.lazydev").init(opts)
    end
}

-- vim: foldmethod=marker
