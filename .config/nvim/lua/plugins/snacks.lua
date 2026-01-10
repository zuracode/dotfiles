---@module 'snacks'

return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    bigfile = { notify = false },
    indent = { animate = { enabled = false }, enabled = true },
    picker = {
      actions = {
        tmux_left = function(self)
          vim.api.nvim_set_current_win(self.main)
          vim.system({ 'tmux', 'select-pane', '-L' })
        end,
      },
      win = {
        input = {
          keys = {
            ['<c-h>'] = { 'tmux_left', mode = { 'i', 'n' } },
          },
        },
        list = {
          keys = {
            ['<c-h>'] = { 'tmux_left', mode = { 'n', 'x' } },
          },
        },
        preview = {
          keys = {
            ['<c-h>'] = 'tmux_left',
          },
        },
      },
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'Explorer',
    },
  },
}
