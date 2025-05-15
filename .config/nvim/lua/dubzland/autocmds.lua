local utils = require("dubzland.utils")

local M = {}

M.init = function()
    local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
    vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
        pattern = '*',
        callback = function()
            vim.o.cursorline = false
            vim.o.cursorcolumn = false
        end,
        group = cursorGrp,
    })
    vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
        pattern = '*',
        callback = function()
            vim.o.cursorline = true
            vim.o.cursorcolumn = true
        end,
        group = cursorGrp,
    })

    local lspGroup = vim.api.nvim_create_augroup('UserLspConfig', {})

    -- Reload cargo workspace when Cargo.toml changes
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*/Cargo.toml',
        group = lspGroup,
        callback = utils.reload_cargo_workspace,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = lspGroup,
        callback = function(ev)
            local bufnr = ev.buf

            -- {{{ Buffer local mappings

            -- {{{ Diagnostics
            utils.keys.nnoremap("<leader>el", vim.diagnostic.setloclist,
                { buffer = bufnr, desc = "Display document diagnostics in location window" })
            utils.keys.nnoremap("<leader>ek", vim.diagnostic.open_float, "Show diagnostic in popup")
            utils.keys.nnoremap("[d", function()
                    vim.diagnostic.jump({ count = -1 })
                end,
                { buffer = bufnr, desc = "Move to the previous diagnostic" })
            utils.keys.nnoremap("]d", function()
                vim.diagnostic.jump({ count = 1 })
            end, { buffer = bufnr, desc = "Move to the next diagnostic" })
            -- }}}

            -- {{{ Token navigation
            utils.keys.nnoremap("gvd", ":vsplit | :lua vim.lsp.buf.definition()<CR>",
                { buffer = bufnr, desc = "Goto definition (in vsplit)" })
            utils.keys.nnoremap("gxd", ":split | :lua vim.lsp.buf.definition()<CR>",
                { buffer = bufnr, desc = "Goto definition (in split)" })
            utils.keys.nnoremap("gd", vim.lsp.buf.definition,
                { buffer = bufnr, desc = "Goto definition (in current window)" })

            utils.keys.nnoremap("gvi", ":vsplit | :lua vim.lsp.buf.implementation()<CR>",
                { buffer = bufnr, desc = "Goto implementation (in vsplit)" })
            utils.keys.nnoremap("gxi", ":split | :lua vim.lsp.buf.implementation()<CR>",
                { buffer = bufnr, desc = "Goto implementation (in split)" })
            utils.keys.nnoremap("gi", vim.lsp.buf.implementation,
                { buffer = bufnr, desc = "Goto implementation (in current window)" })
            utils.keys.nnoremap("gws", vim.lsp.buf.workspace_symbol)
            -- }}}

            -- {{{ LSP
            utils.keys.nnoremap("gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Display references in quickfix" })

            utils.keys.nnoremap("K", function()
                    vim.lsp.buf.hover({ border = 'single' })
                end,
                { buffer = bufnr, desc = "Display info about symbol under cursor in popup" })
            utils.keys.nnoremap("<leader>k", function()
                    vim.lsp.buf.signature_help({ border = 'single' })
                end,
                { buffer = bufnr, desc = "Display signature help in popup" })
            utils.keys.nnoremap("<leader>ca", vim.lsp.buf.code_action,
                { buffer = bufnr, desc = "Show current code actions" })
            -- }}}

            -- {{{ Telescope
            local ok, telescope = pcall(require, "telescope.builtin")
            if ok then
                utils.keys.nnoremap("<leader>r", telescope.lsp_references,
                    { buffer = bufnr, desc = "Telescope - Display references in buffer" })
            end
            -- }}}

            -- }}}

            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })

            if ev and ev.data.client_id then
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local inlayhints
                ok, inlayhints = pcall(require, 'lsp-inlayhints')
                if ok then
                    inlayhints.on_attach(client, bufnr)
                end
                vim.api.nvim_set_option_value('formatexpr', 'v:lua.vim.lsp.formatexpr()', { buf = bufnr })
                vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc()', { buf = bufnr })
                vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc()', { buf = bufnr })
            end
        end,
    })
end

return M

-- vim: foldmethod=marker
