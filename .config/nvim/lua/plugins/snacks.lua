---@module 'snacks'
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  ---@type snacks.Config
  opts = {
    image = {},
    bigfile = { notify = false },
    picker = {
      layout = {
        layout = {
          backdrop = false, -- remove layout's background transparency
        },
      },
      matcher = {
        cwd_bonus = true, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
      },
    },
    explorer = {},
    statuscolumn = {
      left = { 'sign' },
      right = { 'git', 'fold' },
    },
    indent = {
      animate = { enabled = false },
      scope = {
        hl = 'SnacksIndent7',
      },
    },
  },
  keys = {
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart finder',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files({
          hidden = true,
        })
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers list',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Grep for current word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>e',
      function()
        Snacks.input = vim.ui.input
        Snacks.explorer()
      end,
      desc = 'Open file explorer',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
  },
}
