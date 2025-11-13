return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    snippets = {
      preset = "default",
    },
    appearance = {
      -- sets the fallback highlight groups to nvim-cmp's highlight groups
      -- useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release, assuming themes add support
      use_nvim_cmp_as_default = false,
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",
    },
    completion = {
      menu = {
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          components = {
            label_description = {
              text = function(ctx)
                return ctx.label_description ~= '' and ctx.label_description or ctx.item.detail
              end,
            },
          },
          treesitter = { 'lsp' }
        },
      },
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
    },
    keymap = {
      preset = 'enter',
      ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
      ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
    },
    signature = { enabled = true }
  }
}
