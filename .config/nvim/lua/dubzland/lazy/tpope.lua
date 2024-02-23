return {
    {
        'tpope/vim-fugitive',
        config = function(_, opts)
            require("dubzland.config.vim-fugitive").init(opts)
        end,
    },
    'tpope/vim-commentary',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
}

-- vim: foldmethod=marker
