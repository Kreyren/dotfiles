return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  config = function()
    require('indent_blankline').setup({
      buftype_exclude = {
        'NvimTree',
        'terminal',
        'term',
        'gitcommit',
        'fugitive',
        'nofile',
        'Greeter',
      },
      filetype_exclude = {
        'NvimTree',
        'terminal',
        'term',
        'packer',
        'gitcommit',
        'fugitive',
        'nofile',
        'Greeter',
        'qf',
      },
      context_patterns = {
        'class',
        'function',
        'method',
        'block',
        'list_literal',
        'selector',
        '^if',
        '^table',
        'if_statement',
        'while',
        'for',
        'object',
        'start_tag',
        'open_tag',
        'element',
      },
      show_first_indent_level = true,
      show_current_context = true,
      show_trailing_blankline_indent = false,
    })
  end,
}