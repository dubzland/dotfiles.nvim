local utils = require("dubzland.utils")

local nvim_tree_config = {}

nvim_tree_config.init = function(opts)
    require("nvim-tree").setup(opts)
    local nvimtree = require("nvim-tree.api")
    utils.keys.nnoremap("<F3>", nvimtree.tree.toggle, "Toggle NvimTree")
    utils.keys.nnoremap("<leader>n", nvimtree.tree.focus, "Focus NvimTree")
end

return nvim_tree_config

-- vim: foldmethod=marker
