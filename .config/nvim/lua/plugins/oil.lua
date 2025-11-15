return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      signcolumn = "yes:2"
    },
  },
  dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
  lazy = false,
}
