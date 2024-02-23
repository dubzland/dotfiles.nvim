local utils = require("utils")

return {
    {
        'tpope/vim-fugitive',
        config = function()
            utils.keys.nnoremap("<leader>gs", vim.cmd.Git, "Show git status window")
            utils.keys.nnoremap("<leader>gc", ":Git commit", "Open the git commit window")
        end,
    },
    'tpope/vim-commentary',
    'tpope/vim-eunuch',
    'tpope/vim-surround',
}
