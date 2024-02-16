local utils = require 'utils'
local keymaps = require 'keymaps'

local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  callback = function()
    vim.o.cursorline = false
    vim.o.cursorcolumn = false
  end,
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  callback = function()
    vim.o.cursorline = true
    vim.o.cursorcolumn = true
  end,
  group = cursorGrp,
})

local lspGroup = vim.api.nvim_create_augroup('UserLspConfig', {})

-- Reload cargo workspace when Cargo.toml changes
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/Cargo.toml',
  group = lspGroup,
  callback = utils.reload_cargo_workspace,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = lspGroup,
  callback = function(ev)
    local bufnr = ev.buf
    local opts = { buffer = ev.buf }

    -- Buffer local mappings.
    keymaps.lsp(bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
    	buffer = ev.buf,
    	callback = function()
    		vim.lsp.buf.format({ async = false })
    	end,
    })

    if ev and ev.data.client_id then
      local bufnr = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local ok, inlayhints = pcall(require, 'lsp-inlayhints')
      if ok then
        inlayhints.on_attach(client, bufnr)
      end
      vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    end
  end,
})

-- vim: foldmethod=marker
