return {
    {
        'tpope/vim-fugitive',
        config = function()
            require("dubzland.config.vim-fugitive").init()
        end,
    },
    'tpope/vim-commentary',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
}

-- vim: foldmethod=marker
