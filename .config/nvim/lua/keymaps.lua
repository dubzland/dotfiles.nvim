local utils = require("utils")
local silent = { silent = true, noremap = true }

local function opts_or_default(opts)
	if opts == nil then
		opts = {}
	elseif type(opts) == "string" then
		opts = { desc = opts }
	end
	return opts
end

local function map(mode, lhs, rhs, opts)
	opts = opts_or_default(opts)
	vim.keymap.set(mode, lhs, rhs, utils.merge(opts, { silent = true }))
end

local function map_prefix(prefix, mode, lhs, rhs, opts)
	map(mode, prefix .. lhs, rhs, opts)
end

local function nmap(lhs, rhs, opts)
	map("n", lhs, rhs, opts)
end

local function nmap_prefix(prefix, lhs, rhs, opts)
	map("n", prefix .. lhs, rhs, opts)
end

local function nnoremap(lhs, rhs, opts)
	map("n", lhs, rhs, utils.merge(opts_or_default(opts), { noremap = true }))
end

local function nnoremap_prefix(prefix, lhs, rhs, opts)
	nnoremap(prefix .. lhs, rhs, opts)
end

local function vnoremap(lhs, rhs, opts)
	map("v", lhs, rhs, utils.merge(opts_or_default(opts), { noremap = true }))
end

local function vnoremap_prefix(prefix, lhs, rhs, opts)
	vnoremap(prefix .. lhs, rhs, opts)
end

local M = {}

M.init = function()
	-- {{{ Movement
	nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
	nnoremap("<C-h>", "<C-w>h", "Move cursor one buffer to the left")
	nnoremap("<C-j>", "<C-w>j", "Move cursor one buffer down")
	nnoremap("<C-k>", "<C-w>k", "Move cursor one buffer up")
	nnoremap("<C-l>", "<C-w>l", "Move cursor one buffer to the right")
	-- }}}

	nnoremap("<leader><space>", function()
		vim.cmd("noh")
		vim.fn.clearmatches()
	end, "Remove search highlighting, and clear matches from quickfix")

	-- make search very magical
	nnoremap("/", "/\\v")
	vnoremap("/", "/\\v")

	-- Trouble {{{
	if utils.is_available("trouble") then
		local trouble = require("trouble")
		local trouble_prefix = "<leader>x"
		nnoremap_prefix(trouble_prefix, "x", trouble.toggle, "Toggle the trouble window")
		nnoremap_prefix(trouble_prefix, "c", function() trouble.toggle("quickfix") end,
			"Toggle the trouble window (qui[C]kfix)")
		nnoremap_prefix(trouble_prefix, "w", function()
			trouble.toggle("workspace_diagnostics")
		end, "Toggle the trouble window ([W]ocument diagnostics)")
		nnoremap_prefix(trouble_prefix, "d", function()
			trouble.toggle("document_diagnostics")
		end, "Toggle the trouble window ([Document d]iagnostics)")
	end
	-- }}}

	-- {{{ neotest
	if utils.is_available("neotest") then
		local neotest = require("neotest")

		local function run_test_current_file()
			neotest.run.run(vim.fn.expand("%"))
		end

		local function run_test_suite()
			neotest.run.run({ suite = true })
		end

		local function run_test_last()
			neotest.run.run_last()
		end
		nmap("<leader>tt", function()
			neotest.run.run()
		end, "Run nearest test")
		nmap("<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, "Run all tests in current buffer")
		nmap("<leader>ta", function()
			neotest.run.run({ suite = true })
		end, "Run all tests in suite")
		nmap("<leader>tl", function()
			neotest.run.run_last()
		end, "Re-run last test")
		nmap("<leader>to", function()
			neotest.output_panel.toggle()
		end, "Toggle neotest output")
		nmap("<leader>ts", function()
			neotest.summary.toggle()
		end, "Toggle neotest summary")
	end
	-- }}}

	-- {{{ NvimTree
	if utils.is_available("nvim-tree") then
		local nvimtree = require("nvim-tree.api")
		nnoremap("<F3>", nvimtree.tree.toggle, "Toggle NvimTree")
		nnoremap("<leader>n", nvimtree.tree.focus, "Focus NvimTree")
	end
	-- }}}

	-- {{{ Telescope
	if utils.is_available("telescope.builtin") then
		local telescope = require("telescope.builtin")
		nnoremap("<leader>.", telescope.find_files, "Telescope - Find Files")
		nnoremap("<leader>,", telescope.live_grep, "Telescope - Text Search")
		nnoremap("<leader>b", telescope.buffers, "Telescope - Search Buffers")
		nnoremap("<leader>d", telescope.diagnostics, "Telescope - Show Diagnostics")
	end
	-- }}}

	-- {{{ Window manipulation
	nnoremap("<leader>q", require("utils").delete_buffer_keep_window,
		"Close the current buffer, but keep the window open")
	nmap("<leader>co", function()
		vim.cmd("copen")
	end, "Open the quickfix window")
	nmap("<leader>cc", function()
		vim.cmd("cclose")
	end, "Close the quickfix window")
	nmap("<leader>lo", function()
		vim.cmd("lopen")
	end, "Open the location window")
	nmap("<leader>lc", function()
		vim.cmd("lclose")
	end, "Close the location window")
	nmap("<C-W>M", "<C-W>|<C-W>)", "[M]aximize the current buffer")
	nnoremap("<leader>w", function(args)
		require("winshift").cmd_winshift(args)
	end, silent)
end

M.lsp = function(buffer)
	-- {{{ Diagnostics
	nnoremap("<leader>e", vim.diagnostic.setloclist,
		{ buffer = buffer, desc = "Display document diagnostics in location window" })
	nnoremap("[g", vim.diagnostic.goto_prev, { buffer = buffer, desc = "Move to the previous diagnostic" })
	nnoremap("]g", vim.diagnostic.goto_next, { buffer = buffer, desc = "Move to the next diagnostic" })
	-- }}}

	-- {{{ Token navigation
	nnoremap("gvd", ":vsplit | :lua vim.lsp.buf.declaration()<CR>",
		{ buffer = buffer, desc = "Goto declaration (in vsplit)" })
	nnoremap("gxd", ":split | :lua vim.lsp.buf.declaration()<CR>",
		{ buffer = buffer, desc = "Goto declaration (in split)" })
	nnoremap("gfd", vim.lsp.buf.declaration, { buffer = buffer, desc = "Goto declaration (in current window)" })
	nnoremap("gd", vim.lsp.buf.declaration, { buffer = buffer, desc = "Goto declaration (in current window)" })
	-- }}}

	nnoremap("gvD", ":vsplit | :lua vim.lsp.buf.definition()<CR>",
		{ buffer = buffer, desc = "Goto definition (in vsplit)" })
	nnoremap("gxD", ":split | :lua vim.lsp.buf.definition()<CR>",
		{ buffer = buffer, desc = "Goto definition (in split)" })
	nnoremap("gD", vim.lsp.buf.definition, { buffer = buffer, desc = "Goto definition (in current window)" })

	nnoremap("gvi", ":vsplit | :lua vim.lsp.buf.implementation()<CR>",
		{ buffer = buffer, desc = "Goto implementation (in vsplit)" })
	nnoremap("gxi", ":split | :lua vim.lsp.buf.implementation()<CR>",
		{ buffer = buffer, desc = "Goto implementation (in split)" })
	nnoremap("gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "Goto implementation (in current window)" })
	-- }}}

	nnoremap("gr", vim.lsp.buf.references, { buffer = buffer, desc = "Display references in quickfix" })

	nnoremap("K", vim.lsp.buf.hover, { buffer = buffer, desc = "Display info about symbol under cursor in popup" })
	nnoremap("<leader>k", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Display signature help in popup" })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "Show current code actions" })

	local ok, telescope = pcall(require, "telescope.builtin")
	if ok then
		nnoremap("<leader>r", telescope.lsp_references,
			{ buffer = buffer, desc = "Telescope - Display references in buffer" })
	end
end

M.nvim_cmp = function(cmp, luasnip)
	return {
		-- ["<C-p>"] = cmp.mapping.select_prev_item(),
		-- ["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif utils.has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
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
