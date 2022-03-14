return {
  'hrsh7th/nvim-cmp',
  requires = {
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
  },
  branch = 'dev',
  after = { 'nvim-autopairs', 'LuaSnip' },
  config = function()
    local luasnip = require('luasnip')
    luasnip.config.setup({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    })
    local cmp = require('cmp')
    cmp.setup({
      window = {
        completion = {
          border = 'rounded',
        },
        documentation = {
          border = 'rounded',
        },
      },
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = require('keymap').cmp_mappings(),
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'buffer' },
      },
      formatting = {
        format = require('lspkind').cmp_format({ with_text = true }),
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
