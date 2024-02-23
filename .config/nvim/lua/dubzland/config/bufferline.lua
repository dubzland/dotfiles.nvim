local bufferline_config = {}

bufferline_config.init = function(opts)
    opts = opts or {}
    require("bufferline").setup(opts)
end

return bufferline_config
