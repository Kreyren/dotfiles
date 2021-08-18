local utils = require('lspconfig/util')

require('lspconfig').diagnosticls.setup({
  root_dir = utils.root_pattern('.git', '.lua-format'),
  filetypes = {
    'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'scss',
    'css', 'lua',
  },
  init_options = {
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint',
      javascriptreact = 'eslint',
      typescriptreact = 'eslint',
      scss = 'stylelint',
      css = 'stylelint',
    },
    formatFiletypes = {
      typescript = 'prettier',
      typescriptreact = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      css = 'prettier',
      scss = 'prettier',
      lua = 'lua_format',
    },
    linters = {
      eslint = {
        sourceName = 'eslint',
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity',
        },
        securities = { [2] = 'error', [1] = 'warning' },
      },
      stylelint = {
        command = './node_modules/.bin/stylelint',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--formatter', 'json', '--stdin-filename', '%filepath' },
        sourceName = 'stylelint',
        parseJson = {
          errorsRoot = '[0].warnings',
          line = 'line',
          column = 'column',
          message = '${text}',
          security = 'severity',
        },
        securities = { error = 'error', warning = 'warning' },
      },
    },
    formatters = {
      prettier = {
        sourceName = 'prettier',
        rootPatterns = { '.git' },
        command = './node_modules/.bin/prettier',
        args = { '--stdin-filepath', '%filepath' },
      },
      lua_format = {
        sourceName = 'lua_format',
        rootPatterns = { '.lua-format' },
        command = 'lua-format',
        args = { '%filepath' },
      },
    },
  },
})
