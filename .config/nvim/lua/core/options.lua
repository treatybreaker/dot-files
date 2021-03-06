local opt = vim.opt
local g = vim.g

local M = {}

M.setup = function()
	-- Number settings
	opt.number = true
	opt.numberwidth = 2
	opt.relativenumber = true

	-- Scroll Offset
	opt.scrolloff = 3

	-- Disable showmode
	opt.showmode = false

	-- Set truecolor support
	opt.termguicolors = true
	vim.cmd("highlight Normal guibg=none")

	-- Enable system clipboard
	opt.clipboard = "unnamedplus"

	-- Set mouse support for any mode
	opt.mouse = "a"

	-- Allow hidden
	opt.hidden = true

	-- Useful defaults for tab, indentation, etc.
	opt.tabstop = 4
	opt.shiftwidth = 4
	opt.smartindent = true
    opt.breakindent = true
	opt.expandtab = true
	opt.smarttab = true

	-- Search settings
	opt.hlsearch = true
	opt.incsearch = true
	opt.ignorecase = true
	opt.smartcase = true

	-- Better backspaces
	opt.backspace = "indent,eol,start"

	-- Make new splits vertical
	opt.splitright = true

	-- Show line & column num of cursor
	opt.ruler = true

	-- Set timeouts
	opt.ttimeoutlen = 20
	opt.timeoutlen = 1000
    opt.updatetime = 250
    opt.signcolumn = "yes"

	-- Enable persistent undo
	opt.undodir = vim.fn.stdpath("cache") .. "/undo"
	opt.undofile = true

	-- Better folding
	opt.foldmethod = "expr"
	opt.foldexpr = "nvim_treesitter#foldexpr()"
    opt.fillchars = { fold = " " }
	opt.foldlevel = 20

	-- Concealment for nicer rendering
	opt.conceallevel = 2
	opt.concealcursor = "ic"

	-- Lazy Redraw to Speed Up Macros
	opt.lazyredraw = true

	-- Spell Settings
	opt.spelllang = { "en_us" }

    -- Better completion experience
    opt.completeopt = "menuone,noselect"

    -- Set max text width
    opt.textwidth = 120
end

return M
