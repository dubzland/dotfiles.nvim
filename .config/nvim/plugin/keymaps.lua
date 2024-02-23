local utils = require("utils")

utils.keys.nnoremap("<leader>pv", vim.cmd.Ex)
-- {{{ Movement
utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
utils.keys.nnoremap("<C-j>", "<C-w>j", "Move cursor one buffer down")
utils.keys.nnoremap("<C-k>", "<C-w>k", "Move cursor one buffer up")
utils.keys.nnoremap("<C-l>", "<C-w>l", "Move cursor one buffer to the right")
-- }}}

-- {{{ Search
utils.keys.nnoremap("<leader><space>", function()
    vim.cmd("noh")
    vim.fn.clearmatches()
end, "Remove search highlighting, and clear matches from quickfix")

-- make search very magical
utils.keys.nnoremap("/", "/\\v")
utils.keys.vnoremap("/", "/\\v")
-- }}}

-- {{{ Window manipulation
utils.keys.nnoremap("<leader>q", require("utils").delete_buffer_keep_window,
    "Close the current buffer, but keep the window open")
utils.keys.nmap("<leader>wco", function() vim.cmd("copen") end, "Open the quickfix window")
utils.keys.nmap("<leader>wcc", function() vim.cmd("cclose") end, "Close the quickfix window")
utils.keys.nmap("<leader>wlo", function() vim.cmd("lopen") end, "Open the location window")
utils.keys.nmap("<leader>wlc", function() vim.cmd("lclose") end, "Close the location window")
utils.keys.nmap("<C-W>M", "<C-W>|<C-W>)", "[M]aximize the current buffer")
-- }}}

-- vim: foldmethod=marker
