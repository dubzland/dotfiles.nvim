local api = vim.api

local M = {}

function M.reload_cargo_workspace()
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
        if client.name == "rust_analyzer" then
            vim.notify("Reloading Cargo Workspace")
            client.request("rust-analyzer/reloadWorkspace", nil, function(err)
                if err then
                    error(tostring(err))
                end
                vim.notify("Cargo workspace reloaded")
            end, 0)
        end
    end
end

function M.merge(source, target)
    return vim.tbl_deep_extend("force", source, target)
end

function M.has_words_before()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local K = {}

function K.opts_or_default(opts)
    if opts == nil then
        opts = {}
    elseif type(opts) == "string" then
        opts = { desc = opts }
    end
    return opts
end

function K.map(mode, lhs, rhs, opts)
    opts = K.opts_or_default(opts)
    if type(mode) == "string" then
        vim.keymap.set(mode, lhs, rhs, M.merge(opts, { silent = true }))
    else
        for _, m in ipairs(mode) do
            K.map(m, lhs, rhs, opts)
        end
    end
end

function K.map_prefix(prefix, mode, lhs, rhs, opts)
    K.map(mode, prefix .. lhs, rhs, opts)
end

function K.noremap(mode, lhs, rhs, opts)
    opts = K.opts_or_default(opts)
    K.map(mode, lhs, rhs, M.merge(opts, { noremap = true }))
end

function K.noremap_prefix(prefix, mode, lhs, rhs, opts)
    K.noremap(mode, prefix .. lhs, rhs, opts)
end

function K.nmap(lhs, rhs, opts)
    K.map("n", lhs, rhs, opts)
end

function K.nmap_prefix(prefix, lhs, rhs, opts)
    K.map("n", prefix .. lhs, rhs, opts)
end

function K.nnoremap(lhs, rhs, opts)
    K.map("n", lhs, rhs, M.merge(K.opts_or_default(opts), { noremap = true }))
end

function K.nnoremap_prefix(prefix, lhs, rhs, opts)
    K.nnoremap(prefix .. lhs, rhs, opts)
end

function K.vnoremap(lhs, rhs, opts)
    K.map("v", lhs, rhs, M.merge(K.opts_or_default(opts), { noremap = true }))
end

function K.vnoremap_prefix(prefix, lhs, rhs, opts)
    K.vnoremap(prefix .. lhs, rhs, opts)
end

function K.xnoremap(lhs, rhs, opts)
    K.map("x", lhs, rhs, M.merge(K.opts_or_default(opts), { noremap = true }))
end

function K.xnoremap_prefix(prefix, lhs, rhs, opts)
    K.xnoremap(prefix .. lhs, rhs, opts)
end

M.keys = K

return M

-- vim: foldmethod=marker
