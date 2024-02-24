local utils = require("dubzland.utils")

local netrw_config = {}

netrw_config.init = function(opts)
    opts = opts or {}
    require("netrw").setup(opts)
end

return netrw_config

-- vim: foldmethod=marker
