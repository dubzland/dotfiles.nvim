local mason_config = {}

mason_config.init = function(opts)
    opts = opts or {}
    require("mason").setup(opts)
end

return mason_config

-- vim: foldmethod=marker
