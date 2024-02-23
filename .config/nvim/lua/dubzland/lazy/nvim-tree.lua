return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', },
    config = function(_, opts)
        require("dubzland.config.nvim-tree").init(opts)
    end,
}

-- vim: foldmethod=marker
