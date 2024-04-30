return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'tadmccorkle/markdown.nvim',
        },
        build = ":TSUpdate",
        config = function(_, opts)
            require("dubzland.config.treesitter").init(opts)
        end,
    },
}

-- vim: foldmethod=marker
