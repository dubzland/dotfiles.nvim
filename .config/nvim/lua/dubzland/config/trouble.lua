local utils = require("dubzland.utils")

local trouble_config = {}

trouble_config.init = function(opts)
    local trouble = require("trouble")

    trouble.setup(opts)

    local trouble_prefix = "<leader>x"
    utils.keys.nnoremap_prefix(trouble_prefix, "x", trouble.toggle, "Toggle the trouble window")
    utils.keys.nnoremap_prefix(trouble_prefix, "c", function() trouble.toggle("quickfix") end,
        "Toggle the trouble window (qui[C]kfix)")
    utils.keys.nnoremap_prefix(trouble_prefix, "w", function() trouble.toggle("workspace_diagnostics") end,
        "Toggle the trouble window ([W]ocument diagnostics)")
    utils.keys.nnoremap_prefix(trouble_prefix, "d", function() trouble.toggle("document_diagnostics") end,
        "Toggle the trouble window ([Document d]iagnostics)")
end

return trouble_config

-- vim: foldmethod=marker
