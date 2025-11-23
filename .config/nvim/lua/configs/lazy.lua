-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins.vim-tmux-navigator" },
    { import = "plugins.treesitter" },
    { import = "plugins.color-schema" },
    { import = "plugins.trouble" },
    { import = "plugins.tiny-inline-diagnostic" },
    { import = "plugins.blink" },
    { import = "plugins.nvim-lint" },
    { import = "plugins.oil" },
    { import = "plugins.oil-git-status" },
    { import = "plugins.oil-lsp-diagnostics" },
    { import = "plugins.nvim-lspconfig" },
    { import = "plugins.conform" },
    { import = "plugins.neo-tree" },
    { import = "plugins.fzf-lua" },
    { import = "plugins.nvim-web-devicons" },
    { import = "plugins.snacks" },
    { import = "plugins.which-key" },
    { import = "plugins.none-ls" },
    { import = "plugins.plenary" },
    { import = "plugins.harpoon" },
    { import = "plugins.vim-pipeline" },
    { import = "plugins.lualine" },
    { import = "plugins.indent-line" },
    { import = "plugins.autopairs" },
    { import = "plugins.todo-comments" },
    { import = "plugins.gitsigns" }
  },
})
