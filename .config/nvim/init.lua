require("configs.options")
require("configs.keymaps")
require("configs.lazy")
require("configs.autocmd")

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})
vim.lsp.config("lua_ls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("yamlls", {})
vim.lsp.config("ruby_ls", {})
vim.lsp.config("css_variables", {})
vim.lsp.config("cssls", {})
vim.lsp.config("cssmodules_ls", {})
vim.lsp.config("html", {})
vim.lsp.config("tailwindcss", {})
vim.lsp.config("graphql", {})

vim.lsp.enable({ "ts_ls", "lua_ls", "jsonls", "yamlls", "ruby_ls", "css_variables", "cssls", "cssmodules_ls", "html",
  "tailwindcss", "graphql" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    opts.desc = "Go to definition"
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)

    opts.desc = "Symbol highlight"
    vim.keymap.set("n", "grh", vim.lsp.buf.document_highlight, opts)

    opts.desc = "Remove LSP highlight"
    vim.keymap.set({ "n" }, "<C-l>", vim.lsp.buf.clear_references, opts)

    opts.desc = "Show LSP signatures in normal and insert mode"
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
  end,
})
