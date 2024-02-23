local utils = require("utils")
return {
    'nvim-neotest/neotest',
    dependencies = {
        'rouge8/neotest-rust',
        'tpope/vim-dispatch',
        'radenling/vim-dispatch-neovim',
        'vim-test/vim-test',
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest-plenary',
        'nvim-neotest/neotest-python',
        'nvim-neotest/neotest-vim-test',
        'folke/trouble.nvim',
    },
    config = function(_, opts)
        require("neotest").setup(utils.merge({
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
        }, opts))

        vim.g["test#strategy"] = "dispatch"

        local neotest = require("neotest")

        utils.keys.nmap("<leader>tt", function() neotest.run.run() end, "Run nearest test")
        utils.keys.nmap("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,
            "Run all tests in current buffer")
        utils.keys.nmap("<leader>ta", function() neotest.run.run({ suite = true }) end, "Run all tests in suite")
        utils.keys.nmap("<leader>tl", function() neotest.run.run_last() end, "Re-run last test")
        utils.keys.nmap("<leader>to", function() neotest.output_panel.toggle() end, "Toggle neotest output")
        utils.keys.nmap("<leader>ts", function() neotest.summary.toggle() end, "Toggle neotest summary")
    end
}
