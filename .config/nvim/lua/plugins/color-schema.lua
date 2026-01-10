return {
  'catppuccin/nvim',
  name = 'catppuccin-latte',
  priority = 1000,
  config = function()
    require('catppuccin').setup()
    vim.cmd.colorscheme('catppuccin-latte')
  end,
}
