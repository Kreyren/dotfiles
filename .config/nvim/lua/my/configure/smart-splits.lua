return {
  'mrjones2014/smart-splits.nvim',
  dev = true,
  config = function()
    require('smart-splits').setup({
      tmux_integration = true,
    })
  end,
}