local helpers = require('configs.helpers')

return {
  cmd = { 'solargraph', 'stdio' },
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
  filetypes = { 'ruby' },
  root_markers = helpers.root_markers_ruby_with_git,
}
