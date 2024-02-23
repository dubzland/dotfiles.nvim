local utils = require("dubzland.utils")

local lsp_inlayhints_config = {}

lsp_inlayhints_config.init = function(opts)
    opts = opts or {}
    require("lsp-inlayhints").setup(utils.merge({
        inlay_hints = {
            highlight = "Comment",
        },
    }, opts))
end

return lsp_inlayhints_config

-- vim: foldmethod=marker
