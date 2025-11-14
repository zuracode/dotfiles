return {
  "refractalize/oil-git-status.nvim",
  dependencies = {
    "stevearc/oil.nvim",
  },
  config = function()
    require('oil-git-status').setup({
      show_ignored = true,
      symbols = {
        index = {
          ["!"] = "!",
          ["?"] = "?",
          ["A"] = "A",
          ["C"] = "C",
          ["D"] = "D",
          ["M"] = "M",
          ["R"] = "R",
          ["T"] = "T",
          ["U"] = "U",
          [" "] = " ",
        },
        working_tree = {
          ["!"] = "!",
          ["?"] = "?",
          ["A"] = "A",
          ["C"] = "C",
          ["D"] = "D",
          ["M"] = "M",
          ["R"] = "R",
          ["T"] = "T",
          ["U"] = "U",
          [" "] = " ",
        },
      },
    })
  end
}
