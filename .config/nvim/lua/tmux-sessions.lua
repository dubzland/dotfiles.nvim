local utils = require("utils")

local M = {}

if utils.is_available("telescope") then
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    local function tmux_session_select(opts, prompt, finder, handler)
        opts = opts or {}

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

    M.tmux_session_switch = function(opts)
        opts = opts or {}
        local finder = finders.new_oneshot_job({ "tmux-session", "list" }, opts)
        local handler = function(session)
            session = string.match(session, "([^:]+):.*")
            os.execute("tmux-session load " .. session)
        end
        tmux_session_select(opts, "Sessions", finder, handler)
    end

    M.tmux_session_new = function(opts)
        opts = opts or {}
        local finder = finders.new_oneshot_job({ "tmux-session", "targets" }, opts)
        local handler = function(directory)
            os.execute("tmux-session new " .. directory .. " nvim")
        end
        tmux_session_select(opts, "Targets", finder, handler)
    end
else
    M.tmux_session_switch = function(opts) end
    M.tmux_session_new = function(opts) end
end

return M
