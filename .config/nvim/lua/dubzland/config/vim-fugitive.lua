local utils = require("dubzland.utils")

local fugitive_config = {}

fugitive_config.init = function()
    utils.keys.nnoremap("<leader>gs", vim.cmd.Git, "Show git status window")
    utils.keys.nnoremap("<leader>gc", function() vim.cmd.Git("commit") end, "Open the git commit window")
end

return fugitive_config

-- vim: foldmethod=marker
