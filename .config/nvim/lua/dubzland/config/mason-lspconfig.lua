local utils = require("dubzland.utils")

local mason_lsp_config = {}

mason_lsp_config.init = function(opts)
    opts = opts or {}
    local ensure_installed = {
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
    }

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
        ensure_installed = ensure_installed,
    }, opts))
end

return mason_lsp_config

-- vim: foldmethod=marker
