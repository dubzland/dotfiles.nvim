local keymaps = require("keymaps")

local ok

local cmp
ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

local luasnip

ok, luasnip = pcall(require, "luasnip")
if not ok then
	vim.notify("luasnip not available")
	return
end

vim.o.completeopt = "menuone,noinsert,noselect"

cmp.setup({
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert(keymaps.nvim_cmp(cmp, luasnip)),

	-- Installed sources
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp_signature_help" },
	}),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})
