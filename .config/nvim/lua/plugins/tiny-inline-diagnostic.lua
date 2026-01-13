return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    require('tiny-inline-diagnostic').setup({
      options = {
        show_source = {
          enabled = true,
        },
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = true,
        enable_on_insert = false,
      },
    })
    vim.diagnostic.config({
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    })

    vim.keymap.set('n', '<leader>de', '<cmd>TinyInlineDiag enable<cr>', { desc = 'Enable diagnostics' })
    vim.keymap.set('n', '<leader>dd', '<cmd>TinyInlineDiag disable<cr>', { desc = 'Disable diagnostics' })
    vim.keymap.set('n', '<leader>dt', '<cmd>TinyInlineDiag toggle<cr>', { desc = 'Toggle diagnostics' })
  end,
}
