local utils = require("dubzland.utils")

local ibl_config = {}

ibl_config.init = function(opts)
    opts = opts or {}
    require("ibl").setup(utils.merge({ indent = { char = "|" } }, opts))
end

return ibl_config

-- vim: foldmethod=marker
