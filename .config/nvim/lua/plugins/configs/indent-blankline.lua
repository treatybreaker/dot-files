local g = vim.g
g.indent_blankline_char = "▏"
g.space_char_blankline = " "

-- Disable indent-blankline on these pages.
g.indent_blankline_filetype_exclude = {
  "help",
  "terminal",
  "dashboard",
  "packer",
  "lsp-installer",
  "lspinfo",
}

g.indent_blankline_buftype_exclude = { "terminal" }
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = true
