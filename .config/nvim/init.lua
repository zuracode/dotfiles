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
vim.lsp.enable({ "ts_ls", "lua_ls" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- LSP keymaps
    local opts = { buffer = args.buf, silent = true }
    opts.desc = "Go to definition"
    vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)

    opts.desc = "Symbol highlight"
    vim.keymap.set("n", "grh", vim.lsp.buf.document_highlight, opts)

    opts.desc = "Remove LSP highlight"
    vim.keymap.set({ "n" }, "<C-l>", vim.lsp.buf.clear_references, opts)

opts.desc = "Show LSP signatures in normal and insert mode"
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    -- if not client:supports_method('textDocument/willSaveWaitUntil')
    --     and client:supports_method('textDocument/formatting') then
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
    --     buffer = args.buf,
    --     callback = function()
    --       vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
    --     end,
    --   })
    -- end
  end,
})
