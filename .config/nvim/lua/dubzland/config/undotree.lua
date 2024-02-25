local utils = require("dubzland.utils")

local undotree_config = {}

undotree_config.init = function()
    utils.keys.nnoremap("<leader>u", vim.cmd.UndotreeToggle)
end

return undotree_config

-- vim: foldmethod=marker
