local utils = require("dubzland.utils")

local winshift_config = {}

winshift_config.init = function(opts)
    opts = opts or {}

    local winshift = require("winshift")

    winshift.setup(opts)

    utils.keys.nnoremap("<leader>wm", winshift.cmd_winshift,
        "Start window movement")
end

return winshift_config

-- vim: foldmethod=marker
