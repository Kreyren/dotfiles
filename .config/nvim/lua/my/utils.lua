local M = {}

function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

--- Copy specified text to the clipboard.
---@param str string text to copy
function M.copy_to_clipboard(str)
  vim.cmd(string.format('call jobstart("echo %s | pbcopy")', str))
end

--- Returns the git branch, if `cwd` is a git repository
---@return string
function M.git_branch()
  return vim.g.gitsigns_head
end

function M.open_url_under_cursor()
  if vim.fn.has('mac') == 1 then
    vim.cmd('call jobstart(["open", expand("<cfile>")], {"detach": v:true})')
  elseif vim.fn.has('unix') == 1 then
    vim.cmd('call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})')
  else
    vim.notify('Error: gx is not supported on this OS!')
  end
end

return M