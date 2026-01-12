return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      signcolumn = 'yes:2',
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<leader>h'] = { 'actions.select', opts = { horizontal = true } },
      ['<leader>l'] = 'actions.refresh',
    },
  },
  keys = {
    { '<leader>o', '<cmd>Oil<cr>', desc = 'Open Oil' },
  },
}
