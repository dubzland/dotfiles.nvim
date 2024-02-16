local ok, inlay_hints = pcall(require, "lsp-inlayhints")
if ok then
	inlay_hints.setup({
		inlay_hints = {
			highlight = "Comment",
		},
	})
end
