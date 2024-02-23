return {
    'nvim-neotest/neotest',
    dependencies = {
        'rouge8/neotest-rust',
        'tpope/vim-dispatch',
        'radenling/vim-dispatch-neovim',
        'vim-test/vim-test',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest-plenary',
        'nvim-neotest/neotest-python',
        'nvim-neotest/neotest-vim-test',
        'folke/trouble.nvim',
    },
    config = function(_, opts)
        require("dubzland.config.neotest").init(opts)
    end,
}

-- vim: foldmethod=marker
