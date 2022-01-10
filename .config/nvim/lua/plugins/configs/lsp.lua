local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		-- Coq configuration, ensure coq actual has capabilties shown
        capabilities = require("coq").lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	-- In the scenario we're using rust it makes more sense to use rust-tools
	-- see: https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
	--
	-- NOTE: Requires rust_analyzer
	if server.name == "rust_analyzer" then
		-- Dap installation, required vscode and the following extension to be installed:
		-- https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb
		--
		-- locate it with `find ~/ -name `
		-- local extension_path =  "/Users/pricehiller/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
		-- local codelldb_path = extension_path .. 'adapter/codelldb'
		-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
		local rustopts = {
			server = vim.tbl_deep_extend("force", server:get_default_options(), opts, {}),
			-- dap = {
			--     adapter = require('rust-tools.dap').get_codelldb_adapter(
			--     codelldb_path, liblldb_path)
			-- },
			tools = {
				hover_actions = { auto_focus = true },
			},
		}
		require("rust-tools").setup(rustopts)
		server:attach_buffers()
	else
		-- I use ansible a lot, define exceptions for servers that can use
		-- server:setup & vim.cmd at the bottom here
		if server.name == "ansiblels" then
			opts.settings = {
				ansible = {
					ansible = {
						path = "ansible",
					},
					ansibleLint = {
						enabled = true,
						path = "ansible-lint",
					},
					python = {
						interpreterPath = "python3",
					},
				},
			}
		end
		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end
end)
