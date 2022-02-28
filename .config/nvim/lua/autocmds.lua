local M = {}

M.default_autocmds = {
  {
    'BufReadPost',
    [[if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif]],
  },
  {
    name = 'JsonOptions',
    {
      'FileType',
      ':setlocal conceallevel=0',
      opts = { pattern = 'json' },
    },
  },
  {
    name = 'MarkdownOptions',
    {
      'FileType',
      ':setlocal wrap linebreak',
      opts = { pattern = 'markdown' },
    },
  },
  {
    name = 'TerminalBuffers',
    {
      'TermOpen',
      function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.cmd('startinsert')
      end,
    },
    {
      'TermClose',
      ':Bdelete',
    },
  },
}

M.lsp_autocmds = {
  name = 'LspFmt',
  {
    'BufWritePre',
    function()
      require('lsp.utils').format_document()
    end,
    opts = { pattern = '<buffer>' },
  },
}

return M
