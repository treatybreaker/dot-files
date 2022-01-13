local preload_good, preload = pcall(require, "plugins.preload")
if not preload_good then
  print("Preload unable to load...")
end
	
require("core.theme").setup()
require("core.options").setup()
require("core.mappings").setup()


