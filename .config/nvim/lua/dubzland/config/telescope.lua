local utils = require("dubzland.utils")

local telescope_config = {}

telescope_config.init = function(opts)
    require("telescope").setup(utils.merge({
            pickers = {
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                find_files = {
                    follow = true,
                },
            },
        },
        opts))

    local builtin = require("telescope.builtin")
    utils.keys.nnoremap("<leader>.", builtin.git_files, "Telescope - Find Files in git)")
    utils.keys.nnoremap("<C-p>", builtin.find_files, "Telescope - Find Files")
    utils.keys.nnoremap("<leader>,", builtin.live_grep, "Telescope - Text Search")
    utils.keys.nnoremap("<leader>b", builtin.buffers, "Telescope - Search Buffers")
    utils.keys.nnoremap("<leader>d", builtin.diagnostics, "Telescope - Show Diagnostics")

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function tmux_session_select(o, prompt, finder, handler)
        opts = o or {}

        pickers.new(opts, {
            prompt_title = prompt,

            finder = finder,
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    handler(selection[1])
                end)
                return true
            end,
        }):find()
    end

    local function tmux_session_switch(o)
        opts = o or {}
        local finder = finders.new_oneshot_job({ "tmux-session", "list" }, opts)
        local handler = function(session)
            session = string.match(session, "([^:]+):.*")
            os.execute("tmux-session load " .. session)
        end
        tmux_session_select(opts, "Sessions", finder, handler)
    end

    local function tmux_session_new(o)
        opts = o or {}
        local finder = finders.new_oneshot_job({ "tmux-session", "targets" }, opts)
        local handler = function(directory)
            os.execute("tmux-session new " .. directory .. " nvim")
        end
        tmux_session_select(opts, "Targets", finder, handler)
    end

    -- {{{ tmux
    utils.keys.nnoremap("<leader>ss", tmux_session_switch)
    utils.keys.nnoremap("<leader>sn", tmux_session_new)
    -- }}}

    local colors = require("dubzland.colors").values

    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = colors.gui0E })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = colors.gui06, bg = colors.gui00 })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.gui01, bg = colors.gui01 })
    vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = colors.gui07, bg = colors.gui02 })
end

return telescope_config

-- vim: foldmethod=marker
