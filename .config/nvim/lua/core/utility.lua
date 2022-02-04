local M = {}

M.setup = function()
    -- Highlight on yank
    vim.cmd [[
      augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
      augroup end
    ]]
end

return M
