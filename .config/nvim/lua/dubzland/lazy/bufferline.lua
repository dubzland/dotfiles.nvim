return {
    'akinsho/bufferline.nvim',
    config = function(_, opts)
        require("dubzland.config.bufferline").init(opts)
    end,
}

-- vim: foldmethod=marker
