local plugins = {}

-- {{{ lazy.nvim

local Lazy = {}

Lazy.bootstrap = function()
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
end

Lazy.init = function(on_complete)
    Lazy.bootstrap()

    require("lazy").setup({
        spec = "dubzland.lazy",
        change_detection = { notify = false }
    })
    -- }}}

    on_complete()
end

-- }}}

plugins.init = function(on_complete)
    Lazy.init(on_complete)
end

return plugins

-- vim: foldmethod=marker:
