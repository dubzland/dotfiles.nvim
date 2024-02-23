return {
    'lewis6991/gitsigns.nvim',
    config = function(_, opts)
        require("dubzland.config.gitsigns").init(opts)
    end,
}

-- vim: foldmethod=marker
