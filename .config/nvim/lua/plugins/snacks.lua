---@module 'snacks'

return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    bigfile = { notify = false },
    indent = { animate = { enabled = false }, enabled = true },
    picker = {
      trash = true,
      actions = {
        tmux_left = function(self)
          vim.api.nvim_set_current_win(self.main)
          vim.system({ 'tmux', 'select-pane', '-L' })
        end,
        tmux_down = function(self)
          vim.api.nvim_set_current_win(self.main)
          vim.system({ 'tmux', 'select-pane', '-D' })
        end,
        tmux_up = function(self)
          vim.api.nvim_set_current_win(self.main)
          vim.system({ 'tmux', 'select-pane', '-U' })
        end,
        tmux_right = function(self)
          vim.api.nvim_set_current_win(self.main)
          vim.system({ 'tmux', 'select-pane', '-R' })
        end,
      },
      win = {
        input = {
          keys = {
            ['<c-h>'] = { 'tmux_left', mode = { 'i', 'n' } },
            ['<c-j>'] = { 'tmux_down', mode = { 'i', 'n' } },
            ['<c-k>'] = { 'tmux_up', mode = { 'i', 'n' } },
            -- ['<c-l>'] = { 'tmux_right', mode = { 'i', 'n' } },
          },
        },
        list = {
          keys = {
            ['<c-h>'] = { 'tmux_left', mode = { 'n', 'x' } },
            ['<c-j>'] = { 'tmux_down', mode = { 'n', 'x' } },
            ['<c-k>'] = { 'tmux_up', mode = { 'n', 'x' } },
            -- ['<c-l>'] = { 'tmux_right', mode = { 'n', 'x' } },
          },
        },
        preview = {
          keys = {
            ['<c-h>'] = 'tmux_left',
            ['<c-j>'] = 'tmux_down',
            ['<c-k>'] = 'tmux_up',
            -- ['<c-l>'] = 'tmux_right',
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
      desc = 'Explorer open',
    },
  },
}
