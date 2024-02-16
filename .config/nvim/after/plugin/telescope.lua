local ok, telescope = pcall(require, "telescope")
if ok then
	telescope.setup({ pickers = { find_files = { follow = true } } })
end
