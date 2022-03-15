local M = {}

function M.default_autocmds()
  return {
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
      name = 'JsoncFiletypeDetection',
      {
        { 'BufRead', 'BufNewFile' },
        ':set filetype=jsonc',
        opts = {
          pattern = { '*.jsonc', 'tsconfig*.json' },
        },
      },
    },
    {
      -- turn current line blame off in insert mode,
      -- back on when leaving insert mode
      name = 'GitSignsCurrentLineBlameInsertModeToggle',
      {
        { 'InsertLeave', 'InsertEnter' },
        ':Gitsigns toggle_current_line_blame',
      },
    },
  }
end

function M.lsp_autocmds(bufnr)
  return {
    {
      name = 'LspOnAttachAutocmds',
      clear = true,
      {
        'BufWritePost',
        require('lsp.utils').format_document,
        opts = { buffer = bufnr },
      },
      {
        'CursorHold',
        function()
          vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor', border = 'rounded' })
        end,
        opts = { buffer = bufnr },
      },
    },
  }
end

return M
