return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-treesitter/nvim-treesitter-context' },
  opts = function()
    local actions = require('fzf-lua.actions')
    return {
      winopts = {
        title_pos = 'left',
        backdrop = 100,
        preview = {
          title_pos = 'left',
          wrap = 'wrap',
        },
      },
      fzf_opts = {
        ['--no-hscroll'] = '',
        ['--wrap'] = '',
      },
      keymap = {
        fzf = {
          ['ctrl-d'] = 'half-page-down',
          ['ctrl-u'] = 'half-page-up',
          ['ctrl-f'] = 'page-down',
          ['ctrl-b'] = 'page-up',
        },
      },
    }
  end,
  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Find Files in project directory',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Find by grepping in project directory',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').builtin()
      end,
      desc = '[F]ind [B]uiltin FZF',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = '[F]ind current [W]ord',
    },
    {
      '<leader>fW',
      function()
        require('fzf-lua').grep_cWORD()
      end,
      desc = '[F]ind current [W]ORD',
    },
    {
      '<leader><leader>',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[,] Find existing buffers',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').lgrep_curbuf()
      end,
      desc = '[/] Live grep the current buffer',
    },
  },
}
