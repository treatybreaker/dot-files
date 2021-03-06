local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

parser_configs.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

local nvim_treesitter = require("nvim-treesitter.configs")

nvim_treesitter.setup({
	ensure_installed = { "norg", "norg_meta", "norg_table"},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = { "yaml" },
	},
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
    indent = {
        disable = { "yaml" }
    }
})
