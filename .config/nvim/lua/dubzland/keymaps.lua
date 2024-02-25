local utils = require("dubzland.utils")

local M = {}

M.init = function()
    -- {{{ Search
    utils.keys.nnoremap("<leader><space>", function()
        vim.cmd("noh")
        vim.fn.clearmatches()
    end, "Remove search highlighting, and clear matches from quickfix")

    -- make search very magical
    utils.keys.nnoremap("/", "/\\v")
    utils.keys.vnoremap("/", "/\\v")
    -- }}}

    -- {{{ File explorer
    utils.keys.nnoremap("<leader>pv", vim.cmd.Ex)
    -- }}}

    -- {{{ Movement
    utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
    utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
    utils.keys.nnoremap("<C-j>", "<C-w>j", "Move cursor one buffer down")
    utils.keys.nnoremap("<C-k>", "<C-w>k", "Move cursor one buffer up")
    utils.keys.nnoremap("<C-l>", "<C-w>l", "Move cursor one buffer to the right")
    -- }}}

    -- {{{ Text manipulation
    utils.keys.vnoremap("K", ":m '<-2<CR>gv=gv", "Move selected text up one line")
    utils.keys.vnoremap("J", ":m '>+1<CR>gv=gv", "Move selected text down one line")

    utils.keys.noremap({ "n", "v" }, "<leader>y", [["+y]], "Same as y, but to the system clipboard")
    utils.keys.noremap({ "n", "v" }, "<leader>Y", [["+Y]], "Same as Y, but to the system clipboard")

    utils.keys.vnoremap("<leader>p", [["_dP]], "Paste over text without losing register")
    -- }}}

    -- {{{ Window manipulation
    utils.keys.nnoremap("<leader>qk", utils.delete_buffer_keep_window,
        "Close the current buffer, but keep the window open")
    utils.keys.nnoremap("<leader>qq", function() vim.api.nvim_command("bwipeout") end,
        "Close the current buffer, and close the window")
    utils.keys.nmap("<leader>wco", function() vim.cmd("copen") end, "Open the quickfix window")
    utils.keys.nmap("<leader>wcc", function() vim.cmd("cclose") end, "Close the quickfix window")
    utils.keys.nmap("<leader>wlo", function() vim.cmd("lopen") end, "Open the location window")
    utils.keys.nmap("<leader>wlc", function() vim.cmd("lclose") end, "Close the location window")
    utils.keys.nmap("<C-W>M", "<C-W>|<C-W>)", "[M]aximize the current buffer")
    -- }}}
end

return M

-- vim: foldmethod=marker
