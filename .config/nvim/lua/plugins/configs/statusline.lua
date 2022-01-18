local present, lualine = pcall(require, "lualine")
if not present then
	return
end

local left_pad = ""
local right_pad = ""

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = "|",
		section_separators = { left = left_pad, right = right_pad },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 1,
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "fugitive", "fzf" },
})
