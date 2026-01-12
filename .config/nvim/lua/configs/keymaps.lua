-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit insert mode keymap
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode in jk' })
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit insert mode in jj' })

-- LSP signature showing is already mapped with blink.cmp's <CTRL-k>
vim.keymap.set('i', '<CTRL-S>', '<Nop>')

-- Oil nvim keymaps
vim.keymap.set('n', '<leader>o', ':Oil<CR>', { desc = 'Open Oil nvim' })

-- Terminal keymaps
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('resize 15')
  vim.cmd('startinsert')
end, { desc = 'Open terminal below' })

-- Window navigation from terminal mode (use regular vim navigation, not tmux)
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to below window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to above window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right window' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Close terminal window when terminal process exits
vim.api.nvim_create_autocmd('TermClose', {
  callback = function()
    if vim.fn.winnr('$') > 1 then
      vim.cmd('close')
    end
  end,
})
