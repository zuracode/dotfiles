local M = {}

local function insertImmutable(tbl, value)
  local newTable = {}

  -- Copy all existing elements
  for i, v in ipairs(tbl) do
    newTable[i] = v
  end

  -- Add the new value at the end
  newTable[#newTable + 1] = value

  return newTable
end

M.nvim_eleven = vim.fn.has 'nvim-0.11' == 1

M.root_markers_git = '.git'
M.root_markers_js_css_html = { 'package.json', 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb',
  'bun.lock' }
M.root_markers_js_css_with_git = insertImmutable(M.root_markers_js_css_html, M.root_markers_git)
M.root_markers_ruby = { 'Gemfile' }
M.root_markers_ruby_with_git = insertImmutable(M.root_markers_ruby, M.root_markers_git)

function M.root_dir_monorepo(bufnr, on_dir)
  -- The project root is where the LSP can be started from
  -- As stated in the documentation above, this LSP supports monorepos and simple projects.
  -- We select then from the project root, which is identified by the presence of a package
  -- manager lock file.
  local root_markers = M.root_markers_js_css_html

  -- Give the root markers equal priority by wrapping them in a table
  root_markers = M.nvim_eleven and { root_markers, { '.git' } }
      or vim.list_extend(root_markers, { '.git' })
  -- We fallback to the current working directory if no project root is found
  local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

  on_dir(project_root)
end

function M.root_markers_with_field(root_files, new_names, field, fname)
  local path = vim.fn.fnamemodify(fname, ':h')
  local found = vim.fs.find(new_names, { path = path, upward = true, type = 'file' })
  for _, f in ipairs(found or {}) do
    for line in io.lines(f) do
      if line:find(field) then
        root_files[#root_files + 1] = vim.fs.basename(f)
        break
      end
    end
  end
  return root_files
end

function M.insert_package_json(root_files, field, fname)
  return M.root_markers_with_field(root_files, { 'package.json', 'package.json5' }, field, fname)
end

return M
