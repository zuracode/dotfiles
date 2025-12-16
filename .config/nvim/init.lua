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
vim.lsp.config("ruby-lsp", {})
vim.lsp.config("solargraph", {})
vim.lsp.config("css_variables", {})
vim.lsp.config("cssls", {})
vim.lsp.config("cssmodules_ls", {})
vim.lsp.config("html", {})
vim.lsp.config("tailwindcss", {})
vim.lsp.config("graphql", {})
vim.lsp.config("tombi", {})

vim.lsp.enable({ "ts_ls", "lua_ls", "jsonls", "yamlls", "ruby-lsp", "solargraph", "css_variables", "cssls",
  "cssmodules_ls", "html",
  "tailwindcss", "graphql", "tombi" })
