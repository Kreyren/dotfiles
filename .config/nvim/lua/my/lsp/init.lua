local M = {}

function M.setup()
  -- always load null-ls
  require('my.lsp.null-ls')

  -- lazy-load the rest of the configs with
  -- an autocommand that runs only once
  -- for each lsp config
  for filetype, file_patterns in pairs(require('my.lsp.filetypes').filetype_patterns) do
    vim.api.nvim_create_autocmd('BufReadPre', {
      callback = function()
        local _, config = pcall(require, 'my.lsp.' .. filetype)
        -- pcall returns an error string in failure case
        if not config or type(config) ~= 'table' then
          config = {}
        end
        config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        config.on_attach = require('my.lsp.utils').on_attach
        local server = require('my.lsp.filetypes').servers[filetype]
        require('lspconfig')[server].setup(config)
        local snippets = require('my.lsp.snippets')[filetype]
        if snippets then
          snippets()
        end
      end,
      pattern = file_patterns,
      once = true,
    })
  end
end

return M
