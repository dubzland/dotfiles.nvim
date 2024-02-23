return {
    'j-hui/fidget.nvim',
    config = function(_, opts)
        require("dubzland.config.fidget").init(opts)
    end,
}

-- vim: foldmethod=marker
