local format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
    end
    local disable_filetypes = { c = false, cpp = false }

    return {
        timeout_ms = 1000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        async = false
    }
end

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    keys = {
        {
            '<leader>tf',
            function()
                -- If autoformat is currently disabled for this buffer,
                -- then enable it, otherwise disable it
                if vim.b.disable_autoformat then
                    vim.cmd 'FormatEnable'
                    vim.notify 'Enabled autoformat for current buffer'
                else
                    vim.cmd 'FormatDisable!'
                    vim.notify 'Disabled autoformat for current buffer'
                end
            end,
            desc = 'Toggle autoformat for current buffer',
        },
        {
            '<leader>tF',
            function()
                -- If autoformat is currently disabled globally,
                -- then enable it globally, otherwise disable it globally
                if vim.g.disable_autoformat then
                    vim.cmd 'FormatEnable'
                    vim.notify 'Enabled autoformat globally'
                else
                    vim.cmd 'FormatDisable'
                    vim.notify 'Disabled autoformat globally'
                end
            end,
            desc = 'Toggle autoformat globally',
        },
    },
    opts = {
        format_on_save = format_on_save,
        formatters_by_ft = {
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            svelte = { "prettierd" },
            css = { "prettierd" },
            html = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            graphql = { "prettierd" },
            lua = { "stylua" },
            ruby = { "rubocop" },
            tomb = { "tombi" }
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)


        vim.api.nvim_create_user_command('FormatDisable', function(args)
            if args.bang then
                -- :FormatDisable! disables autoformat for this buffer only
                vim.b.disable_autoformat = true
            else
                -- :FormatDisable disables autoformat globally
                vim.g.disable_autoformat = true
            end
        end, {
            desc = 'Disable autoformat-on-save',
            bang = true, -- allows the ! variant
        })

        vim.api.nvim_create_user_command('FormatEnable', function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = 'Re-enable autoformat-on-save',
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            local bufnr = vim.fn.bufnr()
            local format_options = format_on_save(bufnr)

            if format_options ~= nil then
                conform.format(format_options)
                vim.notify("Fomatting triggered")
            end
        end, { desc = "Format file or range (in visual or normal mode)" })
    end,
}
