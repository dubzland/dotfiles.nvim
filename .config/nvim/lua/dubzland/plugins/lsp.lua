return {
    {
        'williamboman/mason.nvim',
        config = function(_, opts)
            require("dubzland.config.mason").init(opts)
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'folke/neodev.nvim',
        },
        config = function(_, opts)
            require("dubzland.config.mason-lspconfig").init(opts)
        end,
    },
    {
        'jay-babu/mason-null-ls.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        config = function(_, opts)
            require("dubzland.config.mason-null-ls").init(opts)
        end,
    },
    {
        'lvimuser/lsp-inlayhints.nvim',
        config = function(_, opts)
            require("dubzland.config.lsp-inlayhints").init(opts)
        end,
    },
}

-- vim: foldmethod=marker
