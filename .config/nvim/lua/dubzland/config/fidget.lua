local utils = require("dubzland.utils")

local fidget_config = {}

fidget_config.init = function(opts)
    opts = opts or {}
    require("fidget").setup(
        utils.merge({
            notification = {
                window = {
                    winblend = 0
                },
            },
        }, opts)
    )
end

return fidget_config
