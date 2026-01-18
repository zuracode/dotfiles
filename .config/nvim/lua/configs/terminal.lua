-- Terminal keymaps
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('resize 15')
  -- Mark this buffer as a user terminal
  vim.b.user_terminal = true

  -- Set buffer-local terminal navigation keymaps (only for user terminals)
  local opts = { buffer = true }
  vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', vim.tbl_extend('force', opts, { desc = 'Move to left window' }))
  vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', vim.tbl_extend('force', opts, { desc = 'Move to below window' }))
  vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', vim.tbl_extend('force', opts, { desc = 'Move to above window' }))
  vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', vim.tbl_extend('force', opts, { desc = 'Move to right window' }))
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', vim.tbl_extend('force', opts, { desc = 'Exit terminal mode' }))

  vim.cmd('startinsert')
end, { desc = 'Open terminal below' })

-- Close terminal window when terminal process exits (only user terminals, not fzf/plugin terminals)
vim.api.nvim_create_autocmd('TermClose', {
  callback = function(ev)
    -- Only auto-close terminals marked as user terminals
    local ok, is_user_terminal = pcall(function()
      return vim.b[ev.buf].user_terminal
    end)

    if ok and is_user_terminal then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(ev.buf) and vim.fn.winnr('$') > 1 then
          pcall(vim.cmd, 'close')
        end
      end)
    end
  end,
})
