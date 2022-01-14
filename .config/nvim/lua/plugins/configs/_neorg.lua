local neorg = require("neorg")

neorg.setup({
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                norg_leader = "<Leader>o"
            }
        },
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    my_workspace = "~/.neorg"
                }
            }
        },
        ["core.integrations.telescope"] = {},
    }
})
