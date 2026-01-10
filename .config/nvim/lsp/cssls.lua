local helpers = require('configs.helpers')

---@type vim.lsp.Config
return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss', 'less' },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = helpers.root_markers_js_css_with_git,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
