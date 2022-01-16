local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = "flex",
		layout_config = {
			vertical = {
				width = 0.90,
				height = 0.98,
				preview_height = 0.65,
			},
			horizontal = {
				width = 0.90,
				height = 0.98,
				preview_width = 0.70,
			},
			flex = {
				flip_cloumns = 120,
			},
		},
	},
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
telescope.load_extension("media_files")
telescope.load_extension("find_directories")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("notify")
