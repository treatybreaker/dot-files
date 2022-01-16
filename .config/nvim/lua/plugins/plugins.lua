local fn = vim.fn

-- Packer strap, install packer automatically and configure plugins
-- See the end of this file for how the variable `packer_strap` gets used
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_STRAP = fn.system({
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
		-- Performance boost on startup
		-- keep at top of plugins
		use({ "lewis6991/impatient.nvim" })

		-- Packer Itself
		use({ "wbthomason/packer.nvim" })

		-- Commonly used library
		use({
			"nvim-lua/plenary.nvim",
		})

		-- Nvim Notify
		use({
			"rcarriga/nvim-notify",
			config = function()
				require("plugins.configs.nvim-notify")
			end,
		})

		-- Color schemes
		use({ "folke/tokyonight.nvim" })

		-- Icons for folders, files, etc.
		use({
			"kyazdani42/nvim-web-devicons",
			event = "BufEnter",
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
			after = {
				"nvim-bufferline.lua",
				"tokyonight.nvim",
			},
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
			event = "BufRead",
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

		-- Lsp From Null LS
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("plugins.configs.null_ls")
			end,
		})

		-- Better LSP Handling for Rust
		use({
			"simrat39/rust-tools.nvim",
			after = "nvim-lspconfig",
			ft = "rust",
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

		use({
			"rafamadriz/friendly-snippets",
			event = "InsertEnter",
		})

		use({
			"hrsh7th/nvim-cmp",
			even = "InsertEnter",
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

		-- Leave at end!!!
		-- Install and deploy packer plugins
		-- automatically
		if PACKER_STRAP then
			vim.notify("Syncing packer from bootstrap")

			function _G.NotifyRestartNeeded()
				local notify_available, _ = require("notify")
				local message = "Neovim Restart Required to Finish Installation!"
				if notify_available then
					vim.notify(message, vim.lsp.log_levels.WARN, {
						title = "Packer Strap",
						keep = function()
							return true
						end,
					})
				else
					vim.notify(message)
				end
			end

			vim.api.nvim_exec(
				[[ 
                autocmd User PackerCompileDone lua NotifyRestartNeeded() 
            ]],
				false
			)
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "double" })
			end,
		},
		compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
	},
})
