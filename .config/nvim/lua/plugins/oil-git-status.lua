return {
  'refractalize/oil-git-status.nvim',
  dependencies = { 'stevearc/oil.nvim' },
  opts = {
    show_ignored = true,
    symbols = {
      index = {
        ['!'] = '!',
        ['?'] = '?',
        [' '] = ' ',
        ['M'] = '󰄱',
        ['A'] = '✚',
        ['D'] = '✖',
        ['R'] = '󰁕',
        ['C'] = '✚',
        ['T'] = 'T',
        ['U'] = 'U',
      },
      working_tree = {
        ['!'] = '!',
        ['?'] = '?',
        [' '] = ' ',
        ['M'] = '󰄱',
        ['A'] = '✚',
        ['D'] = '✖',
        ['R'] = '󰁕',
        ['C'] = '✚',
        ['T'] = 'T',
        ['U'] = 'U',
      },
    },
  },
}
