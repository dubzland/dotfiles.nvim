local utils = require("utils")
local silent = { silent = true, noremap = true }

local M = {}

M.init = function()
    -- {{{ Movement
    utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
    utils.keys.nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
    utils.keys.nnoremap("<C-j>", "<C-w>j", "Move cursor one buffer down")
    utils.keys.nnoremap("<C-k>", "<C-w>k", "Move cursor one buffer up")
    utils.keys.nnoremap("<C-l>", "<C-w>l", "Move cursor one buffer to the right")
    -- }}}

    utils.keys.nnoremap("<leader><space>", function()
        vim.cmd("noh")
        vim.fn.clearmatches()
    end, "Remove search highlighting, and clear matches from quickfix")

    -- make search very magical
    utils.keys.nnoremap("/", "/\\v")
    utils.keys.vnoremap("/", "/\\v")

    -- Trouble {{{
    if utils.is_available("trouble") then
        local trouble = require("trouble")
        local trouble_prefix = "<leader>x"
        utils.keys.nnoremap_prefix(trouble_prefix, "x", trouble.toggle, "Toggle the trouble window")
        utils.keys.nnoremap_prefix(trouble_prefix, "c", function() trouble.toggle("quickfix") end,
            "Toggle the trouble window (qui[C]kfix)")
        utils.keys.nnoremap_prefix(trouble_prefix, "w", function() trouble.toggle("workspace_diagnostics") end,
            "Toggle the trouble window ([W]ocument diagnostics)")
        utils.keys.nnoremap_prefix(trouble_prefix, "d", function() trouble.toggle("document_diagnostics") end,
            "Toggle the trouble window ([Document d]iagnostics)")
    end
    -- }}}

    -- {{{ neotest
    if utils.is_available("neotest") then
        local neotest = require("neotest")

        utils.keys.nmap("<leader>tt", function() neotest.run.run() end, "Run nearest test")
        utils.keys.nmap("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,
            "Run all tests in current buffer")
        utils.keys.nmap("<leader>ta", function() neotest.run.run({ suite = true }) end, "Run all tests in suite")
        utils.keys.nmap("<leader>tl", function() neotest.run.run_last() end, "Re-run last test")
        utils.keys.nmap("<leader>to", function() neotest.output_panel.toggle() end, "Toggle neotest output")
        utils.keys.nmap("<leader>ts", function() neotest.summary.toggle() end, "Toggle neotest summary")
    end
    -- }}}

    -- {{{ NvimTree
    if utils.is_available("nvim-tree") then
        local nvimtree = require("nvim-tree.api")
        utils.keys.nnoremap("<F3>", nvimtree.tree.toggle, "Toggle NvimTree")
        utils.keys.nnoremap("<leader>n", nvimtree.tree.focus, "Focus NvimTree")
    end
    -- }}}

    -- {{{ Telescope
    if utils.is_available("telescope.builtin") then
        local telescope = require("telescope.builtin")
        utils.keys.nnoremap("<leader>.", telescope.find_files, "Telescope - Find Files")
        utils.keys.nnoremap("<leader>,", telescope.live_grep, "Telescope - Text Search")
        utils.keys.nnoremap("<leader>b", telescope.buffers, "Telescope - Search Buffers")
        utils.keys.nnoremap("<leader>d", telescope.diagnostics, "Telescope - Show Diagnostics")
    end
    -- }}}

    -- {{{ Window manipulation
    utils.keys.nnoremap("<leader>q", require("utils").delete_buffer_keep_window,
        "Close the current buffer, but keep the window open")
    utils.keys.nmap("<leader>co", function() vim.cmd("copen") end, "Open the quickfix window")
    utils.keys.nmap("<leader>cc", function() vim.cmd("cclose") end, "Close the quickfix window")
    utils.keys.nmap("<leader>lo", function() vim.cmd("lopen") end, "Open the location window")
    utils.keys.nmap("<leader>lc", function() vim.cmd("lclose") end, "Close the location window")
    utils.keys.nmap("<C-W>M", "<C-W>|<C-W>)", "[M]aximize the current buffer")
    utils.keys.nnoremap("<leader>w", function(args) require("winshift").cmd_winshift(args) end, "Start window movement")
end

M.lsp = function(buffer)
    -- {{{ Diagnostics
    utils.keys.nnoremap("<leader>e", vim.diagnostic.setloclist,
        { buffer = buffer, desc = "Display document diagnostics in location window" })
    utils.keys.nnoremap("[g", vim.diagnostic.goto_prev, { buffer = buffer, desc = "Move to the previous diagnostic" })
    utils.keys.nnoremap("]g", vim.diagnostic.goto_next, { buffer = buffer, desc = "Move to the next diagnostic" })
    -- }}}

    -- {{{ Token navigation
    utils.keys.nnoremap("gvd", ":vsplit | :lua vim.lsp.buf.declaration()<CR>",
        { buffer = buffer, desc = "Goto declaration (in vsplit)" })
    utils.keys.nnoremap("gxd", ":split | :lua vim.lsp.buf.declaration()<CR>",
        { buffer = buffer, desc = "Goto declaration (in split)" })
    utils.keys.nnoremap("gfd", vim.lsp.buf.declaration,
        { buffer = buffer, desc = "Goto declaration (in current window)" })
    utils.keys.nnoremap("gd", vim.lsp.buf.declaration, { buffer = buffer, desc = "Goto declaration (in current window)" })
    -- }}}

    utils.keys.nnoremap("gvD", ":vsplit | :lua vim.lsp.buf.definition()<CR>",
        { buffer = buffer, desc = "Goto definition (in vsplit)" })
    utils.keys.nnoremap("gxD", ":split | :lua vim.lsp.buf.definition()<CR>",
        { buffer = buffer, desc = "Goto definition (in split)" })
    utils.keys.nnoremap("gD", vim.lsp.buf.definition, { buffer = buffer, desc = "Goto definition (in current window)" })

    utils.keys.nnoremap("gvi", ":vsplit | :lua vim.lsp.buf.implementation()<CR>",
        { buffer = buffer, desc = "Goto implementation (in vsplit)" })
    utils.keys.nnoremap("gxi", ":split | :lua vim.lsp.buf.implementation()<CR>",
        { buffer = buffer, desc = "Goto implementation (in split)" })
    utils.keys.nnoremap("gi", vim.lsp.buf.implementation,
        { buffer = buffer, desc = "Goto implementation (in current window)" })
    -- }}}

    utils.keys.nnoremap("gr", vim.lsp.buf.references, { buffer = buffer, desc = "Display references in quickfix" })

    utils.keys.nnoremap("K", vim.lsp.buf.hover,
        { buffer = buffer, desc = "Display info about symbol under cursor in popup" })
    utils.keys.nnoremap("<leader>k", vim.lsp.buf.signature_help,
        { buffer = buffer, desc = "Display signature help in popup" })
    utils.keys.nnoremap("<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Show current code actions" })

    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        utils.keys.nnoremap("<leader>r", telescope.lsp_references,
            { buffer = buffer, desc = "Telescope - Display references in buffer" })
    end
end

M.nvim_cmp = function(cmp, luasnip)
    return {
        -- ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Add tab support
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --	if cmp.visible() then
        --		cmp.select_next_item()
        --	elseif luasnip.expand_or_jumpable() then
        --		luasnip.expand_or_jump()
        --	elseif utils.has_words_before() then
        --		cmp.complete()
        --	else
        --		fallback()
        --	end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --	if cmp.visible() then
        --		cmp.select_prev_item()
        --	elseif luasnip.jumpable(-1) then
        --		luasnip.jump(-1)
        --	else
        --		fallback()
        --	end
        -- end, { "i", "s" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function()
            luasnip.jump(1)
        end),
        ["<S-Tab>"] = cmp.mapping(function()
            luasnip.jump(-1)
        end),
    }
end

M.treesitter = function()
    return {
        incremental_selection = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<M-space>",
        },
        textobjects = {
            select = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
            move = {
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    }
end

return M

-- vim: foldmethod=marker
-- vim: foldmethod=marker
