local present, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
    return
end

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

vim.cmd
[[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
]]
