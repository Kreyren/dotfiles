return {
  'folke/noice.nvim',
  requires = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
    'hrsh7th/nvim-cmp',
  },
  event = 'VimEnter',
  config = function()
    require('noice').setup({
      history = {
        filter = {},
      },
      cmdline = {
        icons = {
          ['/'] = { icon = '  ' },
          ['?'] = { icon = '  ' },
          [':'] = { icon = '  ', firstc = ':' },
        },
      },
      routes = {
        {
          filter = {
            any = {
              { find = 'No active Snippet' },
              { find = '^<$' },
              { kind = 'wmsg' },
            },
          },
          opts = { skip = true },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = vim.o.lines - 4,
            col = 0,
          },
          size = { width = '100%' },
          border = {
            padding = { 0, 3 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:CmdLine,FloatBorder:CmdLineBorder',
          },
        },
      },
    })
  end,
}
