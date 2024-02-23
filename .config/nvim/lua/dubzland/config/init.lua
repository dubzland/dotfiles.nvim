local M = {}

M.init = function()
    require("dubzland.config.base16-vim").init()
    require("dubzland.config.bufferline").init()
    require("dubzland.config.fidget").init()
    require("dubzland.config.gitsigns").init()
    require("dubzland.config.indent-blankline").init()
    require("dubzland.config.lsp-inlayhints").init()
    require("dubzland.config.neodev").init()
    require("dubzland.config.mason").init()
    require("dubzland.config.mason-lspconfig").init()
    require("dubzland.config.mason-null-ls").init()
    require("dubzland.config.neotest").init()
    require("dubzland.config.nvim-cmp").init()
    require("dubzland.config.nvim-tree").init()
    require("dubzland.config.telescope").init()
    require("dubzland.config.treesitter").init()
    require("dubzland.config.trouble").init()
    require("dubzland.config.vim-fugitive").init()
    require("dubzland.config.winshift").init()
end

return M
