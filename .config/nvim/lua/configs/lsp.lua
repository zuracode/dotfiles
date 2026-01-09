vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        opts.desc = "Go to definition"
        vim.keymap.set("n", "grd", vim.lsp.buf.definition, opts)

        opts.desc = "Symbol highlight"
        vim.keymap.set("n", "grh", vim.lsp.buf.document_highlight, opts)

        opts.desc = "Remove LSP highlight"
        vim.keymap.set("n", "<leader>rh", vim.lsp.buf.clear_references, opts)

        opts.desc = "Show LSP signatures in insert mode"
        vim.keymap.set('i', "<C-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "Toggle(disable, enable) LSP diagnostic"
        vim.keymap.set('n', "<leader>rt", function()
            local is_enabled = vim.diagnostic.is_enabled()
            vim.diagnostic.enable(not is_enabled)

            local toggle_status = is_enabled and 'Disabled' or 'Enabled'
            local notification_text = "%s lsp for current buffer"

            vim.notify(string.format(notification_text, toggle_status))
        end, opts)
    end,
})

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
    once = true,
    callback = function(args)
        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
            root_markers = { '.git' }
        })

        -- vim.lsp.enable("ts_ls")
        vim.lsp.enable("lua_ls")

        vim.lsp.enable('vtsls')
        vim.lsp.enable('eslint')
        vim.lsp.enable("jsonls")
        vim.lsp.enable("yamlls")
        vim.lsp.enable("cssls")
        vim.lsp.enable("cssmodules_ls")
        vim.lsp.enable("css_variables")
        vim.lsp.enable("html")
        vim.lsp.enable("tailwindcss")
        vim.lsp.enable("graphql")

        vim.lsp.enable("ruby_lsp")
        vim.lsp.enable("solargraph")
        vim.lsp.enable('rubocop')

        vim.lsp.enable('tombi')
    end,
})
