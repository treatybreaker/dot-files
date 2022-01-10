local nvim_tree = require("nvim-tree")

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
