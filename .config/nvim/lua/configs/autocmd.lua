vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Save and restore folds for specific file types
local view_group = vim.api.nvim_create_augroup('auto_view', { clear = true })
local patter = '*.lua,*.py,*.js,*.ts,*.tsx,*.jsx,*.java,*.c,*.cpp,*.rs,*.go,*.rb'
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  group = view_group,
  pattern = patter,
  desc = 'save view (folds), when closing file',
  callback = function()
    if vim.bo.buftype == '' and not vim.bo.readonly and vim.fn.expand('%') ~= '' then
      vim.cmd('mkview')
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = view_group,
  pattern = patter,
  desc = 'load view (folds), when opening file',
  callback = function()
    if vim.bo.buftype == '' and not vim.bo.readonly and vim.fn.expand('%') ~= '' then
      vim.cmd('silent! loadview')
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'InsertLeave', 'TextChanged' }, {
  pattern = '*.md',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
})
