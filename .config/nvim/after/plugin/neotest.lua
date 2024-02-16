local ok, neotest = pcall(require, "neotest")
if ok then
	vim.g["test#strategy"] = "dispatch"

	neotest.setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "--log-level", "DEBUG" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = "pytest",
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
				python = ".venv/bin/python",
			}),
			require("neotest-rust"),
			require("neotest-vim-test")({
				ignore_file_types = { "python", "vim", "lua" },
			}),
		},
		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = {
			open = function()
				require("trouble").open({ mode = "quickfix", focus = false })
			end,
		},
	})
end
