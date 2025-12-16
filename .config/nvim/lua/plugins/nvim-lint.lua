return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      json = { "jsonlint" },
      yaml = { "yamllint" },
      css = { "stylelint" },
      html = { "htmlhint" },
      lua = { "luac" },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      ruby = { "rubocop" },
      tomb = { "tombi" }
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
      vim.notify("Linting triggered")
    end, { desc = "Trigger linting for current file" })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end
}
