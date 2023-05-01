return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'jose-elias-alvarez/null-ls.nvim',
    {
      'DNLHC/glance.nvim',
      event = 'LspAttach',
      config = function()
        local glance = require('glance')
        glance.setup({
          border = {
            enable = true,
          },
          theme = {
            mode = 'darken',
          },
          -- make win navigation mappings consistent with my default ones
          mappings = {
            list = {
              ['<C-h>'] = glance.actions.enter_win('preview'),
            },
            preview = {
              ['<C-l>'] = glance.actions.enter_win('list'),
            },
          },
        })
      end,
    },
    {
      'williamboman/mason.nvim',
      lazy = false, -- need stuff added to $PATH immediately
      dependencies = {
        {
          'WhoIsSethDaniel/mason-tool-installer.nvim',
          lazy = false,
          cmd = { 'MasonToolsUpdate', 'MasonToolsInstall' },
          config = function()
            require('mason-tool-installer').setup({
              auto_update = true,
              ensure_installed = require('my.lsp.filetypes').mason_packages,
            })
          end,
        },
      },
      cmd = { 'Mason', 'MasonUpdate', 'MasonLog', 'MasonInstall', 'MasonUpdate', 'MasonUninstall' },
      config = function()
        require('mason').setup()
      end,
    },
    'hrsh7th/cmp-nvim-lsp',
    'folke/neodev.nvim',
    'folke/neoconf.nvim',
  },
  event = 'BufReadPre',
  config = function()
    require('neoconf').setup({
      import = {
        coc = false,
        nlsp = false,
      },
    })

    -- make mason.nvim and mason-tools-installer.nvim load and run their configs
    require('mason')
    require('mason-tool-installer')

    -- always load null-ls
    require('my.lsp.null-ls')

    LSP.on_attach(require('my.lsp.utils').on_attach)

    local function setup_lsp_for_filetype(filetype, server_name)
      local has_config, config = pcall(require, 'my.lsp.' .. filetype)
      config = has_config and config or {}
      config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('lspconfig')[server_name].setup(config)
      local snippets = require('my.lsp.snippets')[filetype]
      if snippets then
        snippets()
      end
    end

    local function current_buf_matches_file_patterns(patterns)
      local bufname = vim.fn.expand('%')
      for _, pattern in ipairs(patterns) do
        if string.match(bufname, string.format('.%s', pattern)) then
          return true
        end
      end

      return false
    end

    -- lazy-load the rest of the configs with
    -- an autocommand that runs only once
    -- for each lsp config
    for filetype, filetype_config in pairs(require('my.lsp.filetypes').config) do
      local file_patterns = filetype_config.patterns or { string.format('*.%s', filetype) }
      local server_name = filetype_config.lspconfig
      if file_patterns and server_name then
        -- since we're lazy loading lspconfig itself,
        -- check if we need to start LSP immediately or not
        if current_buf_matches_file_patterns(file_patterns) then
          setup_lsp_for_filetype(filetype, server_name)
        else
          -- if not, set up an autocmd to lazy load the rest
          vim.api.nvim_create_autocmd('BufReadPre', {
            callback = function()
              setup_lsp_for_filetype(filetype, server_name)
            end,
            pattern = file_patterns,
            once = true,
          })
        end
      end
    end
  end,
}
