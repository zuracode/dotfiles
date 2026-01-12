return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neo-tree' },
  },
  opts = {
    close_if_last_window = false,
    enable_git_status = true,
    enable_diagnostics = false,
    popup_border_style = 'rounded',
    use_popups_for_input = true,
    window = {
      position = 'current',
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = false,
      },
      use_libuv_file_watcher = false,
    },
  },
}
