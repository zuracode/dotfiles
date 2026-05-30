local normalize_list = function(t)
  local normalized = {}
  for _, v in pairs(t) do
    if v ~= nil then
      table.insert(normalized, v)
    end
  end
  return normalized
end

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()
    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add mark of buffer in harpoon list' })
  end,
  keys = function()
    local keys = {
      {
        '<leader>fe',
        function()
          local harpoon = require('harpoon')
          Snacks.picker({
            finder = function()
              local file_paths = {}
              local list = normalize_list(harpoon:list().items)
              for i, item in ipairs(list) do
                table.insert(file_paths, { text = item.value, file = item.value })
              end
              return file_paths
            end,
            win = {
              input = {
                keys = { ['<c-x>'] = { 'harpoon_delete', mode = { 'n', 'x', 'v', 'i', 'c', 't' } } },
              },
              list = {
                keys = { ['<c-x>'] = { 'harpoon_delete', mode = { 'n', 'x', 'v', 'i', 'c', 't' } } },
              },
            },
            actions = {
              harpoon_delete = function(picker, item)
                local to_remove = item or picker:selected()
                harpoon:list():remove({ value = to_remove.text })
                harpoon:list().items = normalize_list(harpoon:list().items)

                if #harpoon:list().items == 0 then
                  picker:close()
                end

                picker:find({ refresh = true })
              end,
            },
          })
        end,
        desc = 'Harpoon Snacks menu',
      },
    }
    return keys
  end,
}
