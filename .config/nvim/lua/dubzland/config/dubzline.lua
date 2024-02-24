local utils = require("dubzland.utils")
local colors = require("dubzland.colors")

local dubzline_config = {}

dubzline_config.init = function(opts)
    opts = opts or {}
    require("dubzline").setup(utils.merge({
        excluded = { "NvimTree" },
        colors = colors.values,
    }, opts))
end

return dubzline_config

-- vim: foldmethod=marker
