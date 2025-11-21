return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
      { desc = "Harpoon: Add mark of buffer in harpoon list" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon:" })

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon:" })
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon:" })
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon:" })
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon:" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon:" })
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon:" })
  end,
  keys = function()
    local keys = {
      {
        "<leader>fe",
        function()
          local harpoon = require("harpoon")
          local fzf = require("fzf-lua")

          fzf.fzf_exec(function(fzf_cb)
            for i = 1, harpoon:list():length() do
              local item = harpoon:list():get(i)
              if item and item.value and item.value ~= "" then
                fzf_cb(string.format("%d: %s", i, item.value))
              end
            end
            fzf_cb()
          end, {
            prompt = "Harpoon Files> ",
            winopts = {
              width = 0.4,
              height = 0.4,
            },
            actions = {
              ["default"] = function(selected)
                local idx = tonumber(selected[1]:match("^(%d+):"))
                if idx then
                  harpoon:list():select(idx)
                end
              end,
              ["ctrl-d"] = {
                fn = function(selected)
                  if (selected[1] ~= nil) then
                    local idx = tonumber(selected[1]:match("^(%d+):"))

                    if idx then
                      local item = harpoon:list():get(idx)
                      if item and item.value and item.value ~= "" then
                        harpoon:list():remove(item)
                      end
                    end

                    if harpoon:list():length() == 0 then
                      vim.api.nvim_input('<Esc>')
                    end
                  end
                end,
                reload = true
              }
            },
          })
        end,
        desc = "Harpoon FZF Menu",
      }
    }
    return keys
  end
}
