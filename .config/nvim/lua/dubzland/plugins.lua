local plugins = {}

-- {{{ paq
local function clone_paq()
    local path = vim.fn.stdpath 'data' .. '/site/pack/paqs/start/paq-nvim'
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path }
        return true
    end
end

local function bootstrap_paq(packages)
    local first_install = clone_paq()
    vim.cmd.packadd 'paq-nvim'
    local paq = require 'paq'
    if first_install then
        vim.notify 'Installing plugins... If prompted, hit Enter to continue.'
    end

    -- Read and install packages
    paq(packages)
    paq.install()
end

plugins.init_paq = function(on_complete)
    vim.api.nvim_create_autocmd("User", {
        pattern = "PaqDoneInstall",
        callback = function()
            require("dubzland.config").init()
            on_complete()
        end,
    })

    -- Call helper function
    bootstrap_paq({
        'savq/paq-nvim',

        -- {{{ appearance
        'tinted-theming/base16-vim',
        'akinsho/bufferline.nvim',
        'lewis6991/gitsigns.nvim',
        'lukas-reineke/indent-blankline.nvim',
        { 'nvim-treesitter/nvim-treesitter', { build = ':TSUpdate' } },
        'nvim-treesitter/nvim-treesitter-textobjects',
        'dubzland/dubzline.nvim',
        -- }}}

        -- {{{ diagnostics/notifications
        'folke/trouble.nvim',
        { 'j-hui/fidget.nvim',               { tag = 'v1.4.0' } },
        -- }}}

        -- {{{ LSP
        'williamboman/mason.nvim',
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'lvimuser/lsp-inlayhints.nvim',
        'jay-babu/mason-null-ls.nvim',
        'nvimtools/none-ls.nvim',
        -- }}}

        -- {{{ Completion/snippets
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        { 'L3MON4D3/LuaSnip',              { tag = 'v2.*', build = 'make install_jsregexp' } },
        'saadparwaiz1/cmp_luasnip',
        -- }}}

        -- {{{ tpope ftw
        'tpope/vim-fugitive',
        'tpope/vim-commentary',
        'tpope/vim-eunuch',
        'tpope/vim-surround',
        -- }}}

        -- {{{ window manipluation
        'sindrets/winshift.nvim',
        -- }}}

        'folke/neodev.nvim',

        { 'nvim-telescope/telescope.nvim', { tag = '0.1.5' } },
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',

        'prichrd/netrw.nvim',
        'nvim-tree/nvim-tree.lua',
        -- 'nvim-tree/nvim-web-devicons',

        -- {{{ build/testing
        'nvim-neotest/neotest',
        'rouge8/neotest-rust',
        'tpope/vim-dispatch',
        'radenling/vim-dispatch-neovim',
        'vim-test/vim-test',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest-plenary',
        'nvim-neotest/neotest-python',
        'nvim-neotest/neotest-vim-test',
        -- }}}
    })
end

-- }}}

-- {{{ lazy.nvim

plugins.init_lazy = function(on_complete)
    -- {{{ Initialize lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        spec = "dubzland.lazy",
        change_detection = { notify = false }
    })
    -- }}}

    on_complete()
end

-- }}}

plugins.init = function(on_complete)
    plugins.init_lazy(on_complete)
    -- plugins.init_paq(on_complete)
end

return plugins

-- vim: foldmethod=marker:
