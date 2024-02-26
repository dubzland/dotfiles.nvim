return {
    {
        'akinsho/bufferline.nvim',
        config = function(_, opts)
            require("dubzland.config.bufferline").init(opts)
        end,
    },
    'famiu/bufdelete.nvim',
}

-- vim: foldmethod=marker
