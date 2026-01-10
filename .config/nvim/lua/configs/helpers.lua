local M = {}

function M.insertImmutable(tbl, value)
  local newTable = {}

  -- Copy all existing elements
  for i, v in ipairs(tbl) do
    newTable[i] = v
  end

  -- Add the new value at the end
  newTable[#newTable + 1] = value

  return newTable
end

local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

M.nvim_eleven = vim.fn.has('nvim-0.11') == 1

M.root_markers_git = '.git'
M.root_markers_js_css_html = { 'package.json', 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
M.root_markers_js_css_with_git = M.insertImmutable(M.root_markers_js_css_html, M.root_markers_git)
M.root_markers_ruby = { 'Gemfile' }
M.root_markers_ruby_with_git = M.insertImmutable(M.root_markers_ruby, M.root_markers_git)

function M.root_dir(bufnr, on_dir)
  -- The project root is where the LSP can be started from
  -- As stated in the documentation above, this LSP supports monorepos and simple projects.
  -- We select then from the project root, which is identified by the presence of a package
  -- manager lock file.
  local root_markers = M.root_markers_js_css_html

  -- Give the root markers equal priority by wrapping them in a table
  root_markers = M.nvim_eleven and { root_markers, { '.git' } } or vim.list_extend(root_markers, { '.git' })
  -- We fallback to the current working directory if no project root is found
  local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

  on_dir(project_root)
end

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
local function strip_archive_subpath(path)
  path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
  path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
  return path
end

local function search_ancestors(startpath, func)
  if M.nvim_eleven then
    local validate = vim.validate
    validate('func', func, 'function')
  end
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    guard = guard - 1
    if guard == 0 then
      return
    end
    if func(path) then
      return path
    end
  end
end

local function tbl_flatten(t)
  return M.nvim_eleven and vim.iter(t):flatten(math.huge):totable() or vim.tbl_flatten(t)
end

function M.root_pattern(...)
  local patterns = tbl_flatten({ ... })
  return function(startpath)
    startpath = strip_archive_subpath(startpath)
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
          if vim.uv.fs_stat(p) then
            return path
          end
        end
      end)
      if match ~= nil then
        local real = vim.uv.fs_realpath(match)
        return real or match
      end
    end
  end
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
