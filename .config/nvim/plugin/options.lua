-- General Settings
local opt = vim.opt
opt.visualbell = true
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.gdefault = true
opt.cursorline = true
opt.cursorcolumn = true
opt.scrolloff = 4
opt.sidescrolloff = 10
opt.virtualedit = "block"
opt.foldmethod = "marker"
opt.undofile = true
opt.showbreak = "+++ "
opt.splitbelow = true
opt.splitright = true
opt.shiftround = true
opt.title = true
opt.linebreak = true
opt.colorcolumn = "+1"
-- opt.termguicolors = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.textwidth = 80
opt.cindent = true
opt.omnifunc = "syntaxcomplete#Complete"
-- opt.statusline = '[%n] %f [%{strlen(&fenc)?&fenc:"none"},%{&ff}]%h%m%r%y%{fugitive#statusline()}%=%c,%l/%L %P'
opt.list = true
opt.listchars = {
	tab = "␉ ",
	eol = "¬",
	precedes = "«",
	extends = "»",
}
opt.wildmode = "list:longest"
opt.wildignore =
	".hg,.git,.svn,*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.o,*.obj,*.exe,*.dll,*.so,*.manifest,*.sw?,*.DS_Store"
opt.termguicolors = true
-- Avoid showing extra messages when using completion
-- opt.shortmess = vim.opt.shortmess + "c"

vim.g.python3_host_prog = "~/.local/share/nvim/venv/bin/python"
vim.g.loaded_perl_provider = 0

vim.wo.foldlevel = 1
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
