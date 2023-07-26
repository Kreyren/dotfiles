local efmls = require('efmls-configs')

local node_config = {
  linter = require('efmls-configs.linters.eslint_d'),
  -- switch to prettier_d once I can figure out how to install it with Nix
  formatter = require('efmls-configs.formatters.prettier'),
}

local shell_config = {
  linter = require('efmls-configs.linters.shellcheck'),
  formatter = require('efmls-configs.formatters.shfmt'),
}

efmls.init({
  on_attach = require('my.lsp.utils').on_attach,
  init_options = {
    documentFormatting = true,
  },
})

efmls.setup({
  javascript = node_config,
  typescript = node_config,
  javascriptreact = node_config,
  typescriptreact = node_config,
  bash = shell_config,
  zsh = shell_config,
  sh = shell_config,
  lua = {
    linter = require('efmls-configs.linters.luacheck'),
    formatter = require('efmls-configs.formatters.stylua'),
  },
})
