local telescope = require("telescope")

telescope.setup({
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
        -- file_browser = {
        --     theme = "ivy",
        -- }
	},
})
telescope.load_extension("media_files")
telescope.load_extension("find_directories")
telescope.load_extension("fzf")
telescope.load_extension("file_browser")
