return {
  'williamboman/mason.nvim',
  requires = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  before = 'nvim-lspconfig',
  config = function()
    require('mason').setup()
    require('mason-tool-installer').setup({
      auto_update = true,
      ensure_installed = {
        -- LSP servers
        'css-lsp',
        'html-lsp',
        'json-lsp',
        'typescript-language-server',
        'rust-analyzer',
        'svelte-language-server',
        'gopls',
        'lua-language-server',
        'teal-language-server',

        -- linters
        'eslint_d',
        'shellcheck',
        'luacheck',
        'codespell',

        -- formatters
        'prettierd',
        'stylua',
        'shfmt',
      },
    })
  end,
}