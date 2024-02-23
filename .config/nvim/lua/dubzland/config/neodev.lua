local neodev_config = {}

neodev_config.init = function(opts)
    opts = opts or {}
    require("neodev").setup(opts)
end

return neodev_config

-- vim: foldmethod=marker
