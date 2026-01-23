local helpers = require('configs.helpers')

---@type vim.lsp.Config
return {
  cmd = { 'rubocop', '--lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = helpers.root_markers_ruby_with_git,
}
