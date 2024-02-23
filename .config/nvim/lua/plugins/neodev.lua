return {
    'folke/neodev.nvim',
    config = function(_, opts)
        require("neodev").setup(opts)
    end,
}
