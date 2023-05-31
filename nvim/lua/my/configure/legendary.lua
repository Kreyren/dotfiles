return {
  'mrjones2014/legendary.nvim',
  dev = true,
  dependencies = {
    -- used by key mappings
    'fedepujol/move.nvim',
    'famiu/bufdelete.nvim',
    -- used for frecency sort
    'kkharji/sqlite.lua',
    -- used sometimes for testing integrations
    -- 'folke/which-key.nvim',
    -- {
    --   'nvim-tree/nvim-tree.lua',
    --   cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse' },
    --   setup = true,
    -- },
  },
  lazy = false,
  config = function()
    require('legendary').setup({
      keymaps = require('my.legendary.keymap').default_keymaps(),
      commands = require('my.legendary.commands').default_commands(),
      autocmds = require('my.legendary.autocmds').default_autocmds(),
      funcs = require('my.legendary.functions').default_functions(),
      col_separator_char = ' ',
      default_opts = {
        keymaps = { silent = true, noremap = true },
      },
      extensions = {
        -- nvim_tree = true,
        smart_splits = {
          mods = {
            swap = {
              prefix = '<leader><leader>',
              mod = '',
            },
          },
        },
        op_nvim = true,
        diffview = true,
      },
      -- which_key = { auto_register = true },
    })

    -- require('which-key').setup({
    --   plugins = {
    --     presets = {
    --       operators = false,
    --       motions = false,
    --       text_objects = false,
    --       windows = false,
    --       nav = false,
    --       z = false,
    --       g = false,
    --     },
    --   },
    -- })
    -- require('which-key').register({
    --   name = 'WhichKey: Files', -- optional group name
    --   desc = 'Some which key items',
    --   fq = { '<cmd>Telescope find_files<cr>', 'Find File' },
    -- })
  end,
}