local mason_config = {}

mason_config.init = function(opts)
    require("mason").setup(opts)
end

return mason_config

-- vim: foldmethod=marker
