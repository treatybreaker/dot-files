-- All modules/dirs that are going to be loaded
-- SHOULD have a init.lua file associated with them.
-- init.lua is responsible for loading all configuration
-- related to that directory.
require("plugins.init")
require("core.init")

-- Post load, for things that need to setup keybindings etc after the fact
require("plugins.postload")
