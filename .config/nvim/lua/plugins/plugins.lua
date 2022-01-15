local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	-- Update the runtime so packer can be used
	vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

return require("packer").startup({
	function(use)
		use({ "wbthomason/packer.nvim" })

		-- Performance boost on startup
		-- keep at top of plugins
		use({ "lewis6991/impatient.nvim" })

		-- Commonly used library
		use({
			"nvim-lua/plenary.nvim",
		})

		-- Color schemes
		use({ "folke/tokyonight.nvim" })

		-- Icons for folders, files, etc.
		use({
			"kyazdani42/nvim-web-devicons",
			event = "BufEnter",
		})

		-- File Explorer Tree
		use({
			"kyazdani42/nvim-tree.lua",
			cmd = {
				"NvimTreeOpen",
				"NvimTreeFocus",
				"NvimTreeToggle",
			},
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("plugins.configs._nvim-tree")
			end,
		})

		-- Tab Line at top of editor
		use({
			"akinsho/nvim-bufferline.lua",
			after = "nvim-web-devicons",
			requires = { "nvim-web-devicons" },
			config = function()
				require("plugins.configs.bufferline")
			end,
		})

		-- Statusline.
		use({
			"nvim-lualine/lualine.nvim",
			after = "nvim-bufferline.lua",
			config = function()
				require("plugins.configs.statusline")
			end,
		})

		-- Indentation Guides
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufEnter",
			config = function()
				require("plugins.configs.indent-blankline")
			end,
		})

		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			event = "BufEnter",
			config = function()
				require("plugins.configs.treesitter")
			end,
		})

		-- Highlight given color codes
		use({
			"norcalli/nvim-colorizer.lua",
			event = "BufEnter",
			config = function()
				require("plugins.configs.nvim-colorizer")
			end,
		})

		-- Dashboard when no file is given to nvim
		use({
			"glepnir/dashboard-nvim",
			setup = function()
				require("plugins.configs.dashboard-nvim")
			end,
		})

		-- Telescope Extensions
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		})

		use({
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"artart222/telescope_find_directories",
		})
		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			-- requires = {
			-- 	{ "nvim-lua/plenary.lua" },
			-- 	{ "artart222/telescope_find_directories" },
			-- 	{ "nvim-telescope/telescope-file-browser.nvim" },
			-- 	{
			-- 		"nvim-telescope/telescope-fzf-native.nvim",
			-- 		opt = true,
			-- 		run = "make",
			-- 	},
			-- },
			config = function()
				require("plugins.configs.telescope-nvim")
			end,
		})

		-- LSP, LSP Installer
		use({
			"neovim/nvim-lspconfig",
			event = "BufEnter",
			config = function()
				require("plugins.configs.lspconfig")
			end,
		})

		use({
			"williamboman/nvim-lsp-installer",
			after = "nvim-lspconfig",
			config = function()
				require("plugins.configs.lsp")
			end,
		})

		-- Better LSP Handling for Rust
		use({
			"simrat39/rust-tools.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("rust-tools").setup({})
			end,
		})

		-- Autopairs
		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("nvim-autopairs").setup()
			end,
		})

		-- Completion Engine
		-- use({
		-- 	"ms-jpq/coq_nvim",
		-- 	config = function()
		-- 		require("plugins.configs.coq")
		-- 	end,
		-- 	requires = {
		-- 		"ms-jpq/coq.artifacts",
		-- 		"ms-jpq/coq.thirdparty",
		-- 	},
		-- })
		use({
			"rafamadriz/friendly-snippets",
			event = "InsertEnter",
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"onsails/lspkind-nvim",
				"L3MON4D3/LuaSnip",
			},
			config = function()
				require("plugins.configs.cmp")
			end,
		})

		-- Show code outline
		use({
			"simrat39/symbols-outline.nvim",
			cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		})

		-- DAP, debugger
		use({
			"mfussenegger/nvim-dap",
			event = "BufRead",
		})

		-- Allows more Dap providers to be installed easily
		use({
			"Pocco81/DAPInstall.nvim",
			after = "nvim-dap",
		})

		-- Fancy ui for dap
		use({
			"rcarriga/nvim-dap-ui",
			after = "DAPInstall.nvim",
			config = function()
				require("plugins.configs.dap")
			end,
		})

		-- Floating Command Line
		use({
			"VonHeikemen/fine-cmdline.nvim",
			requires = {
				{ "MunifTanjim/nui.nvim" },
			},
		})

		-- Easy align, better than piping out to !column -t
		use({
			"junegunn/vim-easy-align",
			cmd = { "EasyAlign" },
		})

		-- Code formatting
		use({
			"sbdchd/neoformat",
			cmd = "Neoformat",
		})

		use({
			"anuvyklack/pretty-fold.nvim",
			config = function()
				require("pretty-fold").setup({})
				require("pretty-fold.preview").setup_keybinding()
			end,
		})

		-- Stabalize closing buffers
		use({
			"luukvbaal/stabilize.nvim",
			config = function()
				require("plugins.configs._stabilize")
			end,
		})

		-- Git signs
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			config = function()
				require("gitsigns").setup({})
			end,
		})

		-- Highlight certain comments, TODO, BUG, etc.
		use({
			"folke/todo-comments.nvim",
			event = "BufEnter",
			config = function()
				require("todo-comments").setup({})
			end,
		})

		-- Show possible key bindings during typing
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup()
			end,
		})

		-- Create full path if not existing on write
		use({
			"jghauser/mkdir.nvim",
			cmd = "new",
			config = function()
				require("mkdir")
			end,
		})

		-- Text commenting
		use({
			"terrortylor/nvim-comment",
			cmd = "CommentToggle",
			config = function()
				require("nvim_comment").setup()
			end,
		})

		-- Expands usage of % operator
		use({ "andymass/vim-matchup" })

		-- Move selections with alt+movement key
		use({
			"matze/vim-move",
		})

		-- Register support in telescope with persistent save
		use({
			"AckslD/nvim-neoclip.lua",
			requires = {
				{ "tami5/sqlite.lua", module = "sqlite" },
				{ "nvim-telescope/telescope.nvim" },
			},
			config = function()
				require("plugins.configs._neoclip")
			end,
		})

		-- Markdown Previewer
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			ft = { "markdown" },
			cmd = "MardownPreview",
		})

		-- Allows manipulation of surrounding characters
		use({
			"tpope/vim-surround",
		})

		-- Ansible Syntax Highlighting
		use({
			"pearofducks/ansible-vim",
		})

		-- Better search display
		use({
			"kevinhwang91/nvim-hlslens",
			module = "hlslens",
			keys = "/",
		})

		-- Lsp Diags on scrollbar
		use({
			"petertriho/nvim-scrollbar",
			requires = {
				"kevinhwang91/nvim-hlslens",
				"folke/tokyonight.nvim",
			},
			after = "nvim-hlslens",
			config = function()
				require("plugins.configs.diag-scrollbar")
			end,
		})

		-- Better in-line Lsp Diags
		use({
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			config = function()
				require("lsp_lines").register_lsp_virtual_lines()
			end,
		})

		-- Discord Rich Presence
		use({
			"andweeb/presence.nvim",
			config = function()
				require("presence"):setup({})
			end,
		})

		-- Note Taking
		use({
			"nvim-neorg/neorg",
			config = function()
				require("plugins.configs._neorg")
			end,
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-neorg/neorg-telescope",
			},
			after = "nvim-treesitter",
		})

		-- Completions for /, :, ?
		use({
			"gelguy/wilder.nvim",
		})

		-- Leave at end!!!
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "double" })
			end,
		},
	},
})
