local nvim_treesitter = require("nvim-treesitter.configs")

nvim_treesitter.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = { "yaml" },
  },
  matchup = {
    enable = true,
  },
  -- indent = {
  --   disable = { 'yaml' }
  -- },
  autotag = {
    enable = true
  }
}
