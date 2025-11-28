vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    opts.desc = "Go to definition"
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)

    opts.desc = "Symbol highlight"
    vim.keymap.set("n", "grh", vim.lsp.buf.document_highlight, opts)

    opts.desc = "Remove LSP highlight"
    vim.keymap.set("n", "<leader>rh", vim.lsp.buf.clear_references, opts)

    opts.desc = "Show LSP signatures in normal and insert mode"
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)

    opts.desc = "Toggle LSP diagnostic"
    vim.keymap.set('n', "grt", function()
      local is_enabled = vim.diagnostic.is_enabled()
      vim.diagnostic.enable(not is_enabled)

      local toggle_status = is_enabled and 'Disabled' or 'Enabled'
      local notification_text = "%s lsp for current buffer"

      vim.notify(string.format(notification_text, toggle_status))
    end, opts)
  end,

})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "InsertLeave", "TextChanged" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})
