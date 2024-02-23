local fidget_config = {}

fidget_config.init = function(opts)
    opts = opts or {}
    require("fidget").setup(opts)
end

return fidget_config
