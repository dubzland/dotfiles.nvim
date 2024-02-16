setl ai ts=8 sw=8 sts=8 noet
setl makeprg=pylint\ --output-format=parseable
setl foldenable
setl foldmethod=syntax
setl foldlevel=2
augroup Linting
	autocmd!
	autocmd BufWritePost *.py silent make! <afile> | silent redraw!
	autocmd QuickFixCmdPost [^l]* cwindow
augroup END
