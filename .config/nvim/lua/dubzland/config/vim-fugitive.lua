local utils = require("dubzland.utils")

local fugitive_config = {}

fugitive_config.init = function()
    local fugitive_prefix = "<leader>g"
    utils.keys.nnoremap_prefix(fugitive_prefix, "s", vim.cmd.Git, "Show git status window")
    utils.keys.nnoremap_prefix(fugitive_prefix, "c", function() vim.cmd.Git("commit") end, "Open the git commit window")
    utils.keys.nnoremap_prefix(fugitive_prefix, "v", vim.cmd.Gvdiffsplit, "Open a veritical diff")
end

return fugitive_config

-- vim: foldmethod=marker
