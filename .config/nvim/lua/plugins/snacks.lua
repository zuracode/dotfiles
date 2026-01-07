---@module 'snacks'

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    bigfile = { notify = false },
    indent = { animate = { enabled = false }, enabled = true },
  }
}
