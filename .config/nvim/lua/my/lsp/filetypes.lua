local M = {}

M.filetype_patterns = {
  ['css'] = { '*.css', '*.scss' },
  ['html'] = { '*.html' },
  ['json'] = { '*.json', '*.jsonc' },
  ['typescript'] = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  ['lua'] = { '*.lua' },
  ['rust'] = { '*.rs' },
  ['svelte'] = { '*.svelte' },
  ['teal'] = { '*.tl', '*.d.tl' },
  ['go'] = { '*.go', 'go.mod' },
}

M.filetypes = vim.tbl_keys(M.filetype_patterns)

M.servers = {
  ['csharp'] = 'csharp_ls',
  ['css'] = 'cssls',
  ['go'] = 'gopls',
  ['html'] = 'html',
  ['json'] = 'jsonls',
  ['lua'] = 'sumneko_lua',
  ['rust'] = 'rust_analyzer',
  ['svelte'] = 'svelte',
  ['teal'] = 'teal_ls',
  ['typescript'] = 'tsserver',
}

return M
