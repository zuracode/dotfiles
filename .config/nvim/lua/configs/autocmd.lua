vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'InsertLeave', 'TextChanged' }, {
  pattern = '*.md',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
})
