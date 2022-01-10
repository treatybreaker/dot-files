local opt = vim.opt

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

	-- Enable system clipboard
	opt.clipboard = "unnamedplus"

	-- Set mouse support for any mode
	opt.mouse = "a"

	-- Allow hidden
	opt.hidden = true

	-- Useful defaults for tab, indentionation, etc.
	opt.tabstop = 4
	opt.shiftwidth = 4
	opt.smartindent = true
	opt.smartcase = true
	opt.expandtab = true
	opt.smarttab = true

	-- Search settings
	opt.hlsearch = true
	opt.incsearch = true
	opt.ignorecase = true

	-- Better backspaces
	opt.backspace = "indent,eol,start"

	-- Make new splits vertical
	opt.splitright = true

    -- Show line & column num of cursor
    opt.ruler = true

    -- Set timeouts
    opt.ttimeoutlen = 20
    opt.timeoutlen = 1000

    -- Enable persistent undo
    opt.undofile = true

    -- Better folding
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
	opt.foldtext = "getline(v:foldstart).'...'.trim(getline(v:foldend))"
	opt.foldnestmax = 3
	opt.foldminlines = 1
end

return M
