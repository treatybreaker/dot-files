local lsp_installer = require("nvim-lsp-installer")
local async = require("plenary.async")

local required_servers = {
	"sumneko_lua",
	"rust_analyzer",
	"bashls",
	"eslint",
	"dockerls",
	"yamlls",
}

for _, name in pairs(required_servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			async.run(function()
				vim.notify.async("Installing Language Server " .. name, "info", {
					title = "Lsp Installer",
				}
)
			end)
			server:install()
		end
	end
end

local function on_attach(client, bufnr)
	async.run(function()
		vim.notify.async("Attached server " .. client.name, "info", {
			title = "Lsp Attach",
		}).close()
	end)
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		-- Coq configuration, ensure coq actual has capabilties shown
		capabilities = require("coq").lsp_ensure_capabilities(vim.lsp.protocol.make_client_capabilities()),
		-- capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = on_attach,
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
		elseif server.name == "bashls" then
			opts.settings = {
				filetypes = {
					"zsh",
					"bash",
					"profile",
				},
			}
		end
		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end
end)
