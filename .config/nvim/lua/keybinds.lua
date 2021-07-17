----------------------------------------------------------------
-- NOTE: some additional LSP keybinds live in lsp/utils.lua    --
-- because they only get bound on LSP attach                  --
----------------------------------------------------------------

-- shortcut for vim.api.nvim_set_keymap
local map = vim.api.nvim_set_keymap

-- shortcut for vim.api.nvim_replace_termcodes
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

------------------
-- WINDOW STUFF
------------------
-- jk as alias to <Esc>
map('i', 'jk', t'<Esc>', { noremap = true })

-- keep selection when using < and > for indenting in visual mode
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- <leader>q to close all
map('n', '<leader>q', t':qa<CR>', { noremap = true, silent = true })
-- <leader>s to save all
map('n', '<leader>s', t':wa<CR>', { noremap = true })

-- in insert mode, escape should do the following:
-- - if a coc popup is visible, just close the popup and remain in Insert mode
-- - otherwise, act normal (go to Normal mode)
map('i', '<Esc>', t'pumvisible() ? \'<c-y>\' : \'<Esc>\'', { noremap = true, expr = true, silent = true })

-- toggle nvim-tree with <F3>
map('n', '<F3>', t':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Cycle through nvim-bufferline with ctrl+tab and shift+tab
map('n', '<C-i>', t':BufferLineCycleNext<CR>', { noremap = true, silent = true })
map('n', '<S-tab>', t':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
map('n', 'W', t':exec \'bdelete \' . bufname()<CR>', { noremap = true, silent = true })

-- shift+h/j/k/l for moving around panes
map('n', 'H', t'<C-w>h', { noremap = true, silent = true })
map('n', 'J', t'<C-w>j', { noremap = true, silent = true })
map('n', 'K', t'<C-w>k', { noremap = true, silent = true })
map('n', 'L', t'<C-w>l', { noremap = true, silent = true })

------------------
-- FZF
------------------
-- ff for :Files
map('n', 'ff', t':Files<CR>', { noremap = true, silent = true })
-- fb for :Buffers
map('n', 'fb', t':Buffers<CR>', { noremap = true, silent = true })
-- fh for :History
map('n', 'fh', t':History<CR>', { noremap = true, silent = true })
-- ft for :Rg
map('n', 'ft', t':Rg<CR>', { noremap = true, silent = true })
-- leader+v to find file and open in vsplit
map('n', '<leader>v', t':vsplit<CR>:Files<CR>', { noremap = true, silent = true })
-- leader b for the same but with currently open buffers
map('n', '<leader>b', t':vsplit<CR>:Buffers<CR>', { noremap = true, silent = true })

----------------------------
-- nvim-dashboard Sessions
----------------------------
-- <leader>ss to save session
map('n', '<leader>ss', t'<C-u>SessionSave', { noremap = true })
-- <leader>sl to load session
map('n', '<leader>sl', t'<C-u>SessionLoad', { noremap = true })

------------------------
-- Editing
------------------------
-- <leader>c to toggle comment
map('n', '<leader>c', t':Commentary<CR>', { noremap = true, silent = true })
