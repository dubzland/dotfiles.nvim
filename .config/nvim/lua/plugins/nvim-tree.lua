local utils = require("utils")

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
        local nvimtree = require("nvim-tree.api")
        utils.keys.nnoremap("<F3>", nvimtree.tree.toggle, "Toggle NvimTree")
        utils.keys.nnoremap("<leader>n", nvimtree.tree.focus, "Focus NvimTree")
    end,
}
