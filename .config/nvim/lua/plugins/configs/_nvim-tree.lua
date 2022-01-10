local nvim_tree = require("nvim-tree")
local g = vim.g

g.nvim_tree_auto_ignore_ft = { "dashboard" } -- Don't open tree on specific fiypes.
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened.
g.nvim_tree_indent_markers = 1 -- This option shows indent markers when folders are open.
g.nvim_tree_git_hl = 1 -- Will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0 -- Will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_add_trailing = 0 -- Append a trailing slash to folder names. ]]

nvim_tree.setup({
	auto_close = false,
	open_on_tab = false,
	update_cwd = true,
	hijack_netrw = true,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	filters = {
		custom = {
			".git",
			"node_modules",
			".cache",
			"__pycache__",
		},
	},
	view = {
		width = "15%",
		side = "left",
		auto_resize = true,
		mappings = {
			list = {
				{ key = "<C-h>", cb = require("nvim-tree.config").nvim_tree_callback("toggle_dotfiles") },
			},
		},
	},
})
