local M = {}

M.setup = function()
vim.g.tokyonight_style = "night"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

local loaded, _ = pcall(vim.cmd, "colorscheme tokyonight")

if not loaded then
    vim.notify("Colorscheme could not be loaded likely due to a packerstrap install, restart neovim once packer is done...")
end

end

return M
