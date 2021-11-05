local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  vim.cmd('command! Format :lua require("lsp.utils").formatDocument()')
  vim.cmd([[
    augroup fmt
      autocmd!
      autocmd BufWritePre * Format
    augroup END
  ]])

  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- setup LSP-specific keymaps
  require('nest').applyKeymaps(require('modules.keymaps').lsp)

  require('lsp_signature').on_attach({
    bind = true,
    handler_opts = {
      border = 'single',
    },
    fix_pos = true,
    hint_enable = true,
    hint_prefix = '',
    padding = ' ',
  })

  local ft = vim.bo.filetype
  if
    ft == 'javascript'
    or ft == 'typescript'
    or ft == 'javascriptreact'
    or ft == 'typescriptreact'
    or ft == 'json'
    or ft == 'jsonc'
  then
    -- Disable formatting via tsserver because we're handling formatting via null-ls
    client.resolved_capabilities.document_formatting = false
  end
end

function M.formatDocument()
  -- check if LSP is attached
  if (#vim.lsp.buf_get_clients()) < 1 then
    return
  end

  local ft = vim.bo.filetype
  if ft == 'javascript' or ft == 'typescript' or ft == 'javascriptreact' or ft == 'typescriptreact' then
    local params = {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = '',
    }
    vim.lsp.buf_request_sync(vim.api.nvim_get_current_buf(), 'workspace/executeCommand', params, 1500)
  end
  vim.lsp.buf.formatting_sync(nil, 1500)
end

return M