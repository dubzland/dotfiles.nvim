local api = vim.api

local M = {}

local error_modified = "E89: no write since last change"

-- Borrowed shamelessly from: https://github.com/terrortylor/neovim-environment/blob/main/lua/ui/window/init.lua
function M.delete_buffer_keep_window()
	if api.nvim_buf_get_option(0, "modified") then
		print(error_modified)
	else
		local cur_win = api.nvim_get_current_win()
		local buf_to_delete = api.nvim_get_current_buf()

		local windows = vim.api.nvim_list_wins()
		for _, win in pairs(windows) do
			M.change_buffer(win, buf_to_delete)
		end

		api.nvim_set_current_win(cur_win)
		api.nvim_command("bdelete " .. buf_to_delete)
	end
end

function M.get_buf_id(file)
	local buf = api.nvim_call_function("bufnr", { file })
	return buf
end

function M.change_buffer(window, buf_to_delete)
	api.nvim_set_current_win(window)

	if api.nvim_win_get_buf(window) == buf_to_delete then
		local alt_id = api.nvim_call_function("bufnr", { "#" })

		if alt_id > 0 and api.nvim_buf_is_loaded(alt_id) then
			api.nvim_command("buffer #")
		else
			api.nvim_command("bnext")
			-- bnext can not do anything, so this checks if buffer is still the same
			-- and if so then just create a new buf
			if api.nvim_win_get_buf(window) == buf_to_delete then
				api.nvim_command("enew")
			end
		end
	end
end

function M.reload_cargo_workspace()
	local clients = vim.lsp.get_active_clients()

	for _, client in ipairs(clients) do
		if client.name == "rust_analyzer" then
			vim.notify("Reloading Cargo Workspace")
			client.request("rust-analyzer/reloadWorkspace", nil, function(err)
				if err then
					error(tostring(err))
				end
				vim.notify("Cargo workspace reloaded")
			end, 0)
		end
	end
end

function M.merge(source, target)
	return vim.tbl_deep_extend("force", source, target)
end

function M.has_words_before()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

function M.is_available(plugin)
	local ok, _ = require(plugin)
	return ok
end

return M
