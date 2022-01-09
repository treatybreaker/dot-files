-- Hide ~ from end of lines.
vim.opt.fillchars = { eob = " " }

-- Add icons for lsp diagnostics sings
vim.cmd
[[
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]]

vim.g.tokyonight_style = "night" -- styles: storm, night and day.
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

vim.cmd("colorscheme tokyonight")
