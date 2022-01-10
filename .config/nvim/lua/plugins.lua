local use = require("packer").use

-- Packer Bootstrap per: https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup({function()
    use { "wbthomason/packer.nvim" }

    -- Color schemes.
    use { "folke/tokyonight.nvim" }
    use { "bluz71/vim-nightfly-guicolors" }
    use { "bluz71/vim-moonfly-colors" }
    use { "shaunsingh/nord.nvim" }
    use { "navarasu/onedark.nvim" }
    use { "wuelnerdotexe/vim-enfocado" }


    -- This plugin adds indentation guides to all lines (including empty lines).
    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        config = function()
            require("plugins/indent-blankline")
        end
    }

    -- This plugin show trailing whitespace.
    use {
        "ntpeters/vim-better-whitespace",
        event = "BufRead",
        config = function()
            require("plugins/better-whitespace")
        end
    }

    -- Icons.
    use {
        "kyazdani42/nvim-web-devicons",
        event = "BufEnter"
    }

    -- File explorer tree.
    use {
        "kyazdani42/nvim-tree.lua",
        cmd = {
            "NvimTreeOpen",
            "NvimTreeFocus",
            "NvimTreeToggle",
        },
        config = function()
            require("plugins/nvim-tree")
        end
    }

    -- Bufferline.
    use {
        "akinsho/nvim-bufferline.lua",
        after = "nvim-web-devicons",
        config  = function()
            require("plugins/bufferline")
        end
    }

    -- Statusline.
    use {
        "nvim-lualine/lualine.nvim",
        after = "nvim-bufferline.lua",
        config = function ()
            require("plugins/lualine")
        end
    }

    -- TreeSitter.
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = "BufEnter",
        cmd = {
            "TSInstall",
            "TSInstallSync",
            "TSBufEnable",
            "TSBufToggle",
            "TSEnableAll",
            "TSInstallFromGrammer",
            "TSToggleAll",
            "TSUpdate",
            "TSUpdateSync"
        },
        config = function()
            require("plugins/treesitter")
        end
    }

    -- Colorizer (for highlighting color codes).
    use {
        "norcalli/nvim-colorizer.lua",
        event = "BufEnter",
        config = function()
            require("plugins/colorize")
            vim.cmd("ColorizerAttachToBuffer")
        end
    }

    -- Startup screen.
    use {
        "glepnir/dashboard-nvim",
        cmd = {
            "Dashboard",
            "DashboardChangeColorscheme",
            "DashboardFindFile",
            "DashboardFindHistory",
            "DashboardFindWord",
            "DashboardNewFile",
            "DashboardJumpMarks",
            "SessionLoad",
            "SessionSave"
        },
        setup = function()
            require("plugins/dashboard")
        end
    }

    use {
        "nvim-lua/plenary.nvim",
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim", run = "make",
    }

    use {
        "nvim-lua/popup.nvim",
    }

    use {
        "nvim-telescope/telescope-media-files.nvim",
    }
    use {
        "artart222/telescope_find_directories",
    }
    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            local telescope = require("telescope")

            telescope.setup {
                extensions = {
                    media_files = {
                        filetypes = { "png", "webp", "jpg", "jpeg" },
                        find_cmd = "rg"
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                }
            }
            telescope.load_extension("media_files")
            telescope.load_extension("find_directories")
            telescope.load_extension("fzf")
        end
    }

    -- LSP, LSP installer and tab completion.
    use {
        "neovim/nvim-lspconfig",
        event = "BufEnter",
        config = function()
            require("plugins/lspconfig")
        end
    }

    use {
        "williamboman/nvim-lsp-installer",
        after = "nvim-lspconfig",
        config = function()
            require("../lsp")
        end
    }

    use {
        "rmagatti/goto-preview",
        requires = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("goto-preview").setup({})
        end
    }
    use {
        "kosayoda/nvim-lightbulb",
        module = "nvim-lightbulb"
    }

    use {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu"
    }

    use {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    }

    use {
        "simrat39/rust-tools.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("rust-tools").setup({})
        end
    }

    use {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter"
    }

    -- LSP signature.
    use {
        "ray-x/lsp_signature.nvim",
        after = "friendly-snippets",
        config = function()
            require("lsp_signature").setup()
        end
    }

    -- VsCode like pictograms for lsp.
    use {
        "onsails/lspkind-nvim",
        after = "friendly-snippets"
    }

    -- DAP, debugger
    use {
        "mfussenegger/nvim-dap",
        event = "BufRead",
    }
    use {
        "Pocco81/DAPInstall.nvim",
        after = "nvim-dap"
    }
    use {
        "rcarriga/nvim-dap-ui",
        after = "DAPInstall.nvim",
        config = function ()
            require("plugins/dap")
        end
    }
    -- Code formatter.
    use {
        "sbdchd/neoformat",
        cmd = "Neoformat"
    }

    -- View and search LSP symbols, tags in Neovim.
    use {
        "liuchengxu/vista.vim",
        cmd = "Vista",
        config = function ()
            require("plugins/vista")
        end
    }

    -- Terminal.
    use {
        "akinsho/nvim-toggleterm.lua",
        cmd = "ToggleTerm",
        config = function()
            require("plugins/toggleterm")
        end
    }

    -- Git support for nvim.
    use {
        "tpope/vim-fugitive",
        cmd = "Git"
    }

    -- Git signs.
    use {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end
    }

    -- Auto closes.
    use {
        "windwp/nvim-autopairs",
        after = "coq_nvim",
        config = function()
            require("nvim-autopairs").setup()
        end
    }
    -- This is for html and it can autorename too!
    use {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "php"
        }
    }

    -- -- Scrollbar.
    -- use {
    --     "dstein64/nvim-scrollview",
    --     event = "BufRead",
    --     config = function()
    --         require("plugins/nvim-scroll")
    --     end
    -- }

    -- Smooth scroll.
    use {
        "karb94/neoscroll.nvim",
        event = "BufRead",
        config = function()
            require("neoscroll").setup()
        end
    }
    -- todo-comments is a lua plugin for Neovim to highlight and search for
    -- todo comments like TODO, HACK, BUG in code base.
    use {
        "folke/todo-comments.nvim",
        event = "BufEnter",
        config = function()
            require("plugins/todo-comments")
        end
    }

    -- WhichKey is a lua plugin that displays a popup with possible
    -- key bindings of the command you started typing.
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    }

    -- A plugin for neovim that automatically creates missing directories
    -- on saving a file.
    use {
        "jghauser/mkdir.nvim",
        cmd = "new",
        config = function()
            require("mkdir")
        end
    }

    -- Neovim plugin to comment text in and out.
    -- Supports commenting out the current line, a visual selection and a motion.
    use {
        "terrortylor/nvim-comment",
        cmd = "CommentToggle",
        config = function()
            require("nvim_comment").setup()
        end
    }

    -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
    use { "andymass/vim-matchup" }

    -- With this plugin you can resize Neovim buffers easily.
    use {
        "artart222/vim-resize",
        event = "BufEnter"
    }


    -- Useful code block movements
    use {
        "matze/vim-move"
    }

    -- Fancier dropdown menus
    use {
        "stevearc/dressing.nvim"
    }

    -- Very useful search functionality, duplicates / & ?
    use {
        "VonHeikemen/searchbox.nvim",
        requires = {
            { "MunifTanjim/nui.nvim" }
        }
    }


    -- Register support in telescope with persistent save
    use {
        "AckslD/nvim-neoclip.lua",
        requires = {
            {"tami5/sqlite.lua", module = "sqlite"},
            {"nvim-telescope/telescope.nvim"}
        },
        config = function()
            require("neoclip").setup({
                enable_persistant_history = true,
            })
        end,
    }

    -- Markdown Previewer
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_browser = ""
        end,
        ft = { "markdown" },
    }


    use {
        "ms-jpq/coq_nvim",
        config = function()
            require("plugins/coq")
        end
    }

    use {
        "ms-jpq/coq.artifacts"
    }

    use {
        "ms-jpq/coq.thirdparty"
    }

    use {
        "tpope/vim-surround"
    }

    use {
        "pearofducks/ansible-vim",
        config = function()
            -- vim.g.ansible_unindent_after_newline = 1
            vim.g.ansible_attribute_highlight = "ob"
            -- vim.g.ansible_template_syntaxes = { "*.rb.j2": "ruby"
            --     "*.bash.j2": "bash",
            --     "*.sh.j2": "sh",
            --     "*.py.j2": "python3"
            -- }
        end

    }

    use {
        "kevinhwang91/nvim-hlslens",
        module = "hlslens",
        keys = "/",
    }

    use {
        requires = { "kevinhwang91/nvim-hlslens" },
        after ="nvim-hlslens",
        "petertriho/nvim-scrollbar",
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                handle = {
                    color = colors.bg_highlight,
                },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
                handlers = {
                    diagnostic = true,
                    search = true
                }
            })
        end
    }
    use {
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup{}
            require("pretty-fold.preview").setup_keybinding()
        end
    }
    use({
        "catppuccin/nvim",
        as = "catppuccin",
    })


    -- Bootstrap packer if not installed, sync packages
    if packer_bootstrap then
        require('packer').sync()
    end

end,
config = {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "double" })
        end
    }
}}
)
