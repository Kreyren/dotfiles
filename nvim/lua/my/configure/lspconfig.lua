local nvim_navbuddy_telescope
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'folke/neodev.nvim', event = 'BufReadPre' },
    {
      'creativenull/efmls-configs-nvim',
      dev = true,
      -- neoconf must be loaded before any LSP
      dependencies = { 'folke/neoconf.nvim' },
    },
    {
      'folke/neoconf.nvim',
      event = 'BufReadPre',
      opts = {
        import = {
          coc = false,
          nlsp = false,
        },
      },
    },
    {
      'SmiteshP/nvim-navbuddy',
      dependencies = {
        'SmiteshP/nvim-navic',
        'MunifTanjim/nui.nvim',
      },
      opts = {
        lsp = { auto_attach = true },
        window = { sections = { right = { preview = 'always' } } },
        mappings = {
          -- structured like this to avoid having to `require('nvim-navbuddy')` during startup
          ['/'] = {
            callback = function(display)
              if nvim_navbuddy_telescope == nil then
                nvim_navbuddy_telescope = require('nvim-navbuddy.actions').telescope({
                  layout_config = {
                    height = 0.60,
                    width = 0.60,
                    prompt_position = 'top',
                    preview_width = 0.50,
                  },
                  layout_strategy = 'horizontal',
                })
              end
              return nvim_navbuddy_telescope.callback(display)
            end,
            description = 'Fuzzy search current level with telescope',
          },
        },
      },
      keys = {
        {
          '<F4>',
          function()
            require('nvim-navbuddy').open()
          end,
          desc = 'Jump to symbol',
        },
      },
    },
    {
      'DNLHC/glance.nvim',
      event = 'LspAttach',
      config = function()
        local glance = require('glance')
        glance.setup({ ---@diagnostic disable-line:missing-fields
          border = {
            enable = true,
          },
          theme = {
            enable = true,
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
      'chrisgrieser/nvim-rulebook',
      keys = {
        {
          '<leader>ri',
          function()
            require('rulebook').ignoreRule()
          end,
          desc = 'Add comment to ignore diagnostic error/warning rules',
        },
        {
          '<leader>rl',
          function()
            require('rulebook').lookupRule()
          end,
          desc = 'Look up rule documentation for error/warning diagnostics',
        },
      },
    },
  },
  event = 'BufReadPre',
  init = function()
    LSP.on_attach(require('my.lsp.utils').on_attach)
  end,
  config = function()
    local efm_setup_done = false

    local function setup_lsp_for_filetype(filetype, server_name)
      local has_config, config = pcall(require, 'my.lsp.' .. filetype)
      config = has_config and config or {}
      config.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- setup efmls if not done already
      if not efm_setup_done and require('my.lsp.filetypes').uses_efm(filetype) then
        efm_setup_done = true
        require('lspconfig').efm.setup(require('my.lsp.filetypes').efmls_config(config.capabilities))
      end

      require('lspconfig')[server_name].setup(config)
      local snippets = require('my.lsp.snippets')[filetype]
      if snippets then
        snippets()
      end
    end

    local function current_buf_matches_file_patterns(patterns)
      local bufname = vim.api.nvim_buf_get_name(0)
      for _, pattern in ipairs(patterns) do
        if string.match(bufname, string.format('.%s', pattern)) then
          return true
        end
      end

      return require('my.lsp.filetypes').uses_efm(vim.bo.ft)
    end

    local function setup_server(filetype, file_patterns, server_name)
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

    -- lazy-load the rest of the configs with
    -- an autocommand that runs only once
    -- for each lsp config
    for filetype, filetype_config in pairs(require('my.lsp.filetypes').config) do
      local file_patterns = filetype_config.patterns or { string.format('*.%s', filetype) }
      local server_name = filetype_config.lspconfig
      if file_patterns and server_name then
        if type(server_name) == 'table' then
          for _, server in ipairs(server_name) do
            setup_server(filetype, file_patterns, server)
          end
        else
          setup_server(filetype, file_patterns, server_name)
        end
      end
    end
  end,
}
