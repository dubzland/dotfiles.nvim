local utils = require("dubzland.utils")

local lazydev_config = {}

lazydev_config.init = function(opts)
    opts = opts or {}
    utils.merge({
        debug = true,
    }, opts)
end

return lazydev_config
