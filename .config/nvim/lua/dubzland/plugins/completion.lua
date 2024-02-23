return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            build = 'make install_jsregexp'
        },
        'saadparwaiz1/cmp_luasnip',
    },
    config = function(_, opts)
        require("dubzland.config.nvim-cmp").init(opts)
    end,
}

-- vim: foldmethod=marker
