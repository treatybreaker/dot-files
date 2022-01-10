local treesitter = require("nvim-tree.configs")

treesitter.setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = {
            -- Ansible support reasons
            "ansible.yaml",
        },
	},
	matchup = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
