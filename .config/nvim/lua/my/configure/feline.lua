return {
  'freddiehaddad/feline.nvim',
  dependencies = {
    {
      'SmiteshP/nvim-navic',
      init = function()
        LSP.on_attach(function(client, bufnr)
          if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufnr)
          end
        end)
      end,
      config = function()
        require('nvim-navic').setup({
          highlight = true,
          separator = '  ',
        })
      end,
    },
  },
  event = 'VimEnter',
  config = function()
    vim.opt.laststatus = 3
    local colors = require('onedarkpro.helpers').get_colors()
    local mode_icons = {
      ['n'] = '🅽',
      ['no'] = '🅽',
      ['nov'] = '🅽',
      ['noV'] = '🅽',
      ['no'] = '🅽',
      ['niI'] = '🅽',
      ['niR'] = '🅽',
      ['niV'] = '🅽',
      ['v'] = '🆅',
      ['V'] = '🆅',
      [''] = '🆅',
      ['s'] = '🆂',
      ['S'] = '🆂',
      [''] = '🆂',
      ['i'] = '🅸',
      ['ic'] = '🅸',
      ['ix'] = '🅸',
      ['R'] = '🆁',
      ['Rc'] = '🆁',
      ['Rv'] = '🆁',
      ['Rx'] = '🆁',
      ['r'] = '🆁',
      ['rm'] = '🆁',
      ['r?'] = '🆁',
      ['c'] = '🅲',
      ['cv'] = '🅲',
      ['ce'] = '🅲',
      ['!'] = '🆃',
      ['t'] = '🆃',
      ['nt'] = '🆃',
    }

    local mode_colors = {
      ['NORMAL'] = colors.green,
      ['OP'] = colors.green,
      ['INSERT'] = colors.blue,
      ['VISUAL'] = colors.yellow,
      ['LINES'] = colors.yellow,
      ['BLOCK'] = colors.yellow,
      ['REPLACE'] = colors.purple,
      ['V-REPLACE'] = colors.purple,
      ['ENTER'] = colors.cyan,
      ['MORE'] = colors.cyan,
      ['SELECT'] = colors.orange,
      ['COMMAND'] = colors.blue,
      ['SHELL'] = colors.green,
      ['TERM'] = colors.green,
      ['NONE'] = colors.yellow,
    }

    local diagnostics_icons = require('my.lsp.icons')
    local diagnostics_ui = {
      [vim.diagnostic.severity.HINT] = { icon = diagnostics_icons.Hint, color = colors.cyan },
      [vim.diagnostic.severity.INFO] = { icon = diagnostics_icons.Info, color = colors.blue },
      [vim.diagnostic.severity.WARN] = { icon = diagnostics_icons.Warning, color = colors.yellow },
      [vim.diagnostic.severity.ERROR] = { icon = diagnostics_icons.Error, color = colors.red },
    }
    local diagnostics_order = {
      vim.diagnostic.severity.HINT,
      vim.diagnostic.severity.INFO,
      vim.diagnostic.severity.WARN,
      vim.diagnostic.severity.ERROR,
    }

    local function unsaved_buffers_count()
      if #vim.fn.expand('%') == 0 then
        return 0
      end

      return #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_get_option(buf, 'modifiable') and vim.api.nvim_buf_get_option(buf, 'modified')
      end, vim.api.nvim_list_bufs())
    end

    local function unsaved_changes()
      local unsaved_buffers = unsaved_buffers_count()
      if #vim.fn.expand('%') == 0 or unsaved_buffers == 0 then
        return ''
      end
      return string.format(' %s unsaved file%s ', unsaved_buffers, unsaved_buffers > 1 and 's' or '')
    end

    local function is_current_buf()
      return vim.api.nvim_get_current_buf() == tonumber(vim.g.actual_curbuf)
    end

    local components = {
      mode = {
        left_sep = 'block',
        provider = function()
          local mode = vim.api.nvim_get_mode().mode
          return mode_icons[mode] .. ' '
        end,
        hl = function()
          return {
            fg = colors.bg_statusline,
            bg = require('feline.providers.vi_mode').get_mode_color(),
            bold = true,
          }
        end,
        right_sep = {
          str = 'right_rounded',
          hl = function()
            ---@diagnostic disable-next-line
            if vim.b.gitsigns_head then
              return {
                fg = require('feline.providers.vi_mode').get_mode_color(),
                bg = colors.gray,
              }
            end
          end,
        },
      },
      branch = {
        left_sep = 'block',
        provider = 'git_branch',
        icon = ' ',
        hl = {
          bg = colors.gray,
          fg = colors.green,
        },
        right_sep = 'right_rounded',
        enabled = function()
          ---@diagnostic disable-next-line
          return not not vim.b.gitsigns_head
        end,
      },
      file_info = {
        left_sep = 'block',
        provider = {
          name = 'file_info',
          opts = {
            file_readonly_icon = ' ',
            type = 'relative',
          },
        },
        right_sep = 'right_rounded',
        enabled = function()
          local bufname = vim.api.nvim_buf_get_name(tonumber(vim.g.actual_curbuf) or 0)
          return bufname ~= '' and not vim.startswith(bufname, 'component://')
        end,
      },
      file_info_short = {
        left_sep = 'block',
        provider = {
          name = 'file_info',
          opts = {
            file_readonly_icon = ' ',
            type = 'unique',
          },
        },
        hl = function()
          return {
            bg = is_current_buf() and colors.bg or colors.dark_gray,
          }
        end,
        right_sep = 'block',
        enabled = function()
          return vim.api.nvim_buf_get_name(tonumber(vim.g.actual_curbuf) or 0) ~= ''
        end,
      },
      op = {
        left_sep = 'left_rounded',
        provider = function()
          -- don't load the plugin just for the statusline component
          if not vim.g.op_nvim_remote_loaded then
            return ' 1P: Signed Out'
          end
          return require('op.statusline').component()
        end,
        hl = {
          bg = colors.blue,
          fg = colors.gray,
        },
        right_sep = 'block',
      },
      unsaved_changes = {
        left_sep = 'left_rounded',
        provider = unsaved_changes,
        enabled = function()
          return unsaved_buffers_count() > 0
        end,
        icon = '',
        hl = {
          bg = colors.yellow,
          fg = colors.black,
        },
        right_sep = {
          str = 'right_rounded',
          hl = {
            bg = colors.bg_statusline,
            fg = colors.yellow,
          },
        },
      },
      diagnostics = function(severity, is_winbar)
        if is_winbar == nil then
          is_winbar = false
        end

        local ui = diagnostics_ui[severity]
        return {
          enabled = (not is_winbar) or function()
            return require('feline.providers.lsp').diagnostics_exist(severity)
          end,
          left_sep = (not is_winbar) and severity == diagnostics_order[1] and {
            str = 'left_rounded',
            hl = {
              bg = colors.blue,
              fg = colors.bg_statusline,
            },
          } or nil,
          provider = function()
            return tostring(#vim.tbl_filter(function(diag)
              return diag.severity == severity
            end, vim.diagnostic.get(0)))
          end,
          icon = ui.icon,
          hl = {
            fg = ui.color,
            bg = colors.bg_statusline,
          },
          right_sep = 'block',
        }
      end,
      navic = {
        provider = function()
          return require('nvim-navic').get_location()
        end,
        enabled = function()
          -- prevent loading nvim-navic is LSP isn't attached anyway
          local buf = tonumber(vim.g.actual_curbuf)
          if #vim.lsp.get_active_clients({ bufnr = buf }) == 0 then
            return false
          end

          return require('nvim-navic').is_available()
        end,
        hl = {
          bg = colors.bg_statusline,
        },
        left_sep = {
          str = ' ',
          hl = { bg = colors.bg_statusline },
        },
        right_sep = {
          str = ' ',
          hl = { bg = colors.bg_statusline },
        },
      },
      winbar_spacer = {
        provider = function()
          return ''
        end,
        right_sep = {
          str = ' ',
          hl = {
            fg = colors.darker_gray,
            bg = colors.darker_gray,
          },
        },
      },
      lazy_stats = {
        provider = function()
          local icon = require('lazy.core.config').options.ui.icons.plugin
          local stats = require('lazy').stats()
          local updates = require('lazy.status').has_updates()
              and string.format(' (%s updates available)', tostring(require('lazy.status').updates()):gsub(icon, ''))
            or ''
          return string.format('%s %s/%s%s', icon, stats.loaded, stats.count, updates)
        end,
        right_sep = {
          str = 'block',
        },
      },
    }

    local function with_diagnostics(components_tbl, is_winbar)
      for _, severity in ipairs(diagnostics_order) do
        table.insert(components_tbl, components.diagnostics(severity, is_winbar))
      end
      return components_tbl
    end

    local statusline_components = {
      { components.mode, components.branch, components.file_info },
      { components.unsaved_changes },
      with_diagnostics({ components.lazy_stats, components.op }, false),
    }

    local winbar_components = {
      with_diagnostics({ components.file_info_short, components.winbar_spacer, components.navic }, true),
      {},
      {},
    }

    local shared_config = {
      default_bg = colors.bg_statusline,
      default_fg = colors.bg_statusline,
      vi_mode_colors = mode_colors,
    }

    require('feline').setup(vim.tbl_deep_extend('force', shared_config, {
      components = {
        active = statusline_components,
        inactive = statusline_components,
      },
    }))

    require('feline').winbar.setup(vim.tbl_deep_extend('force', shared_config, {
      components = {
        active = winbar_components,
        inactive = winbar_components,
      },
    }))
  end,
}
