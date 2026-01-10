local helpers = require('configs.helpers')

---@type vim.lsp.Config
return {
  cmd = { 'cssmodules-language-server' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = helpers.root_markers_js_css_with_git,
}
