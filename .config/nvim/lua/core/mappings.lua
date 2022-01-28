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

end

return M
