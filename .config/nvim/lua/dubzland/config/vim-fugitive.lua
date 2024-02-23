local utils = require("dubzland.utils")

local fugitive_config = {}

fugitive_config.init = function()
    utils.keys.nnoremap("<leader>gs", vim.cmd.Git, "Show git status window")
    utils.keys.nnoremap("<leader>gc", ":Git commit", "Open the git commit window")
end

return fugitive_config

-- vim: foldmethod=marker
