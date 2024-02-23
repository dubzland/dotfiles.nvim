local utils = require("utils")

return {
    'sindrets/winshift.nvim',
    dependencies = {
        'tinted-theming/base16-vim',
    },
    config = function(_, opts)
        local winshift = require("winshift")

        winshift.setup(opts)

        utils.keys.nnoremap("<leader>wm", winshift.cmd_winshift,
            "Start window movement")
    end
}
