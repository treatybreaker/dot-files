local g = vim.g
local fn = vim.fn

local plugins_count = fn.len(fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))

g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"

g.dashboard_custom_header = {
	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

g.dashboard_custom_section = {
	a = { description = { "  Find File" }, command = "Telescope find_files" },
	b = { description = { "  Find directory" }, command = "Telescope find_directories" },
	c = { description = { "  Recents" }, command = "Telescope oldfiles" },
	d = { description = { "  Find Word" }, command = "Telescope live_grep" },
	e = { description = { "洛 New File" }, command = "DashboardNewFile" },
	f = { description = { "  Bookmarks" }, command = "Telescope marks" },
	g = { description = { "  Load Last Session" }, command = "SessionLoad" },
}

g.dashboard_custom_footer = {
	"Loaded " .. plugins_count .. " plugins!  ",
}

-- Disable statusline and cursorline in dashboard.
vim.cmd('autocmd BufEnter * if &ft is "dashboard" | set laststatus=0 | else | set laststatus=2 | endif')
vim.cmd('autocmd BufEnter * if &ft is "dashboard" | set nocursorline | endif')
