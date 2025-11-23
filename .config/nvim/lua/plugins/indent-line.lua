local highlight = {
  "Whitespace",
}
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { highlight = highlight, char = "│" },
    scope = { show_start = false }
  },
}
