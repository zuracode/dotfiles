return {
    "nvimtools/none-ls.nvim",
    dependencies = { "davidmh/cspell.nvim" },
    config = function()
        local cspell = require('cspell')

        local config = {
            config_file_preferred_name = 'cspell.json',
            cspell_config_dirs = { "~/.config/" }
        }
        require("null-ls").setup {
            sources = {
                cspell.diagnostics.with({ config = config, diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["INFO"]
                end, }),
                cspell.code_actions.with({ config = config }),
            }
        }
        table.insert(
            {},
            cspell.diagnostics.with({
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["INFO"]
                end,
            })
        )
        table.insert({}, cspell.code_actions)
    end
}
