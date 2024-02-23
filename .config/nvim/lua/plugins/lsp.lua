local utils = require("utils")

return {
    { 'williamboman/mason.nvim', config = true },
    -- {{{ mason-lspconfig.nvim
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'folke/neodev.nvim',
        },
        opts = {
            ensure_installed = {
                "bashls",
                "clangd",
                "eslint",
                "gopls",
                "jsonls",
                "lua_ls",
                "marksman",
                "pyright",
                "rust_analyzer",
                "solargraph",
                "taplo",
                "terraformls",
                "tsserver",
            },
        },
        config = function(_, opts)
            local handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = require("cmp_nvim_lsp").default_capabilities() })
                end,
                ["rust_analyzer"] = function()
                    require("lspconfig").rust_analyzer.setup({
                        capabilities = utils.merge({
                            experimental = {
                                commands = {
                                    commands = {
                                        "rust-analyzer.runSingle",
                                        "rust-analyzer.debugSingle",
                                        "rust-analyzer.showReferences",
                                        "rust-analyzer.gotoLocation",
                                        "editor.action.triggerParameterHints",
                                    },
                                },
                            },
                        }, require("cmp_nvim_lsp").default_capabilities()),
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = {
                                    command = "clippy",
                                },
                                cargo = {
                                    allFeatures = true,
                                },
                                completion = {
                                    fullFunctionSignatures = {
                                        enable = true,
                                    },
                                },
                            },
                        },
                    })
                end
            }

            require("mason-lspconfig").setup(utils.merge({
                handlers = handlers,
            }, opts))
        end,
    },
    -- }}}
    {
        'jay-babu/mason-null-ls.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'williamboman/mason.nvim',
            'nvimtools/none-ls.nvim',
        },
        opts = {
            ensure_installed = { "black", "prettier" },
            handlers = {},
        },
    },
    {
        'lvimuser/lsp-inlayhints.nvim',
        opts = {
            inlay_hints = {
                highlight = "Comment",
            },
        },
    },
}

-- vim: foldmethod=marker
