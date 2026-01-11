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

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: toggle to previous buffer' })
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: toggle to next buffer' })
  end,
  keys = function()
    local keys = {
      {
        '<leader>fe',
        function()
          local harpoon = require('harpoon')
          local fzf = require('fzf-lua')
          local utils = require('fzf-lua.utils')

          local opts = fzf.config.normalize_opts({}, fzf.config.globals.grep)
          local header = ':: ' .. utils.ansi_from_hl(opts.hls.header_bind, '<ctrl-x>') .. ' to ' .. utils.ansi_from_hl(opts.hls.header_text, 'delete')

          fzf.fzf_exec(function(fzf_cb)
            for i = 1, harpoon:list():length() do
              local item = harpoon:list():get(i)
              if item and item.value and item.value ~= '' then
                fzf_cb(item.value)
              end
            end
            fzf_cb()
          end, {
            prompt = 'Harpoon> ',
            previewer = 'builtin',
            fzf_opts = {
              ['--header'] = header,
            },
            actions = {
              ['default'] = function(selected)
                if selected[1] then
                  vim.cmd('edit ' .. vim.fn.fnameescape(selected[1]))
                end
              end,
              ['ctrl-x'] = {
                fn = function(selected)
                  if selected[1] then
                    local list = harpoon:list()
                    for i = list:length(), 1, -1 do
                      local item = list:get(i)
                      if item and item.value == selected[1] then
                        list:remove(item)
                        break
                      end
                    end

                    if list:length() == 0 then
                      vim.api.nvim_input('<Esc>')
                    end
                  end
                end,
                reload = true,
              },
            },
          })
        end,
        desc = 'Harpoon FZF Menu',
      },
    }
    return keys
  end,
}
