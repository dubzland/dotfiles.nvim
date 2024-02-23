return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function(_, opts)
        require("dubzland.config.indent-blankline").init(opts)
    end,
}

-- vim: foldmethod=marker
