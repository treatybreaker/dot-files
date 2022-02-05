local utils = require("utils.init")
local map = utils.map
local M = {}

M.setup = function()
	-- set mapleader to space
	vim.g.mapleader = " "

	-- Get rid of highlight after search
	map("n", "<esc>", ":noh<CR>")

    -- Spell Checking
    map("n", "<leader>st",":set spell!<CR>")

    -- Better split movement
    map("n", "<C-l>", "<C-w>l")
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-k>", "<C-w>k")
    map("n", "<C-j>", "<C-w>j")

    -- Better Split Opening
    map("n", "<C-s>", "<C-w>s")
    map("n", "<C-v>", "<C-w>v")

    -- Better split closing
    map("n", "<C-x>", "<C-w>c")

end

return M
