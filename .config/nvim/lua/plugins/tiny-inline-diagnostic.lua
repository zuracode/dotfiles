
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      options = {
        show_source = {
          enabled = true,
        },
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = true,
        enable_on_insert = true,
      },
    })
    vim.diagnostic.config({
      virtual_text = false,  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' '
    }}
   })
  end,
}
