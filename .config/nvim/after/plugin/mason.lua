local ok

local mason
ok, mason = pcall(require, "mason")
if ok then
    mason.setup()
end

local mason_lspconfig
ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
    mason_lspconfig.setup({
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
    })
end

local null_ls

ok, null_ls = pcall(require, "null-ls")
if ok then
    null_ls.setup()
end

local mason_null_ls
ok, mason_null_ls = pcall(require, "mason-null-ls")
if ok then
    mason_null_ls.setup({
        ensure_installed = { "black", "prettier" },
        handlers = {},
    })
end
