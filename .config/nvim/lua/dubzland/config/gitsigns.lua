local utils = require("dubzland.utils")

local gitsigns_config = {}

gitsigns_config.init = function(opts)
    require("gitsigns").setup(utils.merge({
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
    }, opts))
end

return gitsigns_config

-- vim: foldmethod=marker
