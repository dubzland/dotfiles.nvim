local utils = require("dubzland.utils")

local mason_null_ls_config = {}

mason_null_ls_config.init = function(opts)
    opts = opts or {}
    require("mason-null-ls").setup(utils.merge({
        ensure_installed = { "black", "prettier" },
    }, opts))
end

return mason_null_ls_config

-- vim: foldmethod=marker
