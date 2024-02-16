local utils = require("utils")

local ok, lspconfig, cmp_nvim_lsp

if utils.is_available("neodev") then
	vim.notify("Initializing neodev")
	require("neodev").setup({
		override = function(root_dir, options)
			-- vim.notify("In override")
			vim.notify(vim.fn.printf("root_dir: %s, options: %s", root_dir, options))
		end,
	})
end

ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
	return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.lua_ls.setup({
	capabilities = capabilities
})
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({
	capabilities = utils.merge({
		experimental = {
			commands = {
				commands = {
					"rust-analyzer.runSingle",
					"rust-analyzer.debugSingle",
					"rust-analyzer.showReferences",
					"rust-analyzer.gotoLocation",
					"editor.action.triggerParameterHints",
				},
			},
		},
	}, capabilities),
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			cargo = {
				allFeatures = true,
			},
			completion = {
				fullFunctionSignatures = {
					enable = true,
				},
			},
		},
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})
