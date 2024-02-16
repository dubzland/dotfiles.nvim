local ok, ibl = pcall(require, "ibl")
if ok then
	ibl.setup({ indent = { char = "|" } })
end
