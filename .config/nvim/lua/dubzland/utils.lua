local api = vim.api

local M = {}

local error_modified = "E89: no write since last change"

function M.delete_buffer_keep_window()
    local buf_to_delete = api.nvim_get_current_buf()

    -- If the buffer is modified, prevent delete
    if api.nvim_get_option_value("modified", { buf = buf_to_delete }) then
        print(error_modified)
        return
    end

    -- Find a valid buffer to switch to
    local alt_id = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            alt_id = buf
            break
        end
    end

    -- Remove this buffer from any open windows
    local windows = vim.api.nvim_list_wins()
    for _, win in pairs(windows) do
        if api.nvim_win_get_buf(win) == buf_to_delete then
            if alt_id > 0 then
                api.nvim_win_set_buf(win, alt_id)
            else
                api.nvim_win_call(win, function() api.nvim_command("enew") end)
            end
        end
    end

    -- actually delete the buffer
    api.nvim_buf_delete(buf_to_delete, {})
end

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
