local utils = require("utils.init")
local map = utils.map

-- Telescope mappings
map("n", "<Leader>tw", ":Telescope live_grep<CR>")
map("n", "<Leader>gs", ":Telescope git_status<CR>")
map("n", "<Leader>gc", ":Telescope git_commits<CR>")
map("n", "<Leader>gb", ":Telescope git_branches<CR>")
map("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
map("n", "<Leader>tf", ":Telescope find_files find_command=rg,--follow,--hidden,--files<CR>")
map("n", "<Leader>td", ":Telescope find_directories<CR>")
map("n", "<Leader>tb", ":Telescope buffers<CR>")
map("n", "<Leader>th", ":Telescope help_tags<CR>")
map("n", "<Leader>to", ":Telescope oldfiles<CR>")
map("n", "<leader>tc", ":Telescope neoclip default<CR>")
map("n", "<leader>tr", ":Telescope registers<CR>")
map("n", "<leader>tt", ":Telescope file_browser<CR>")
map("n", "<leader>ts", ":Telescope spell_suggest<CR>")


-- Lsp Mappings
map("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>")
map("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>")
map("n", "<leader>k", ":lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>K", ":lua vim.lsp.buf.signature_help()<CR>")
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>la", ":lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<leader>lx", ":lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<leader>ll", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<leader>lT", ":lua vim.lsp.buf.type_definition()<CR>")
map("n", "<leader>ln", ":lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>lc", ":CodeActionMenu<CR>")
map("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>")
map("n", "<leader>ls", ":lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})<CR>")
map("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>")
map("n", "<leader>[", ":lua vim.diagnostic.goto_prev()<CR>")
map("n", "<leader>]", ":lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>lq", ":Telescope diagnostics bufnr=0<CR>")

-- Formatter
map("n", "<leader>fr", ":Neoformat<CR>")

-- DAP Mappings
map("n", "<leader>dR", ':lua require("dap").continue()<CR>')
map("n", "<leader>de", ':lua require("dap").terminate()<CR>')
map("n", "<leader>db", ':lua require("dap").toggle_breakpoint()<CR>')
map("n", "<leader>dr", ":lua require(\"dap\").set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>dp", ":lua require(\"dap\").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<F5>", ':lua require("dap").step_over()<CR>')
map("n", "<F6>", ':lua require("dap").step_into()<CR>')
map("n", "<F7>", ':lua require("dap").step_out()<CR>')
map("n", "<leader>dB", ':lua require("dap").step_back()<CR>')
map("n", "<leader>dc", ':lua require("dap").run_to_cursor()<CR>')
map("n", "<leader>do", ':lua require("dap").repl.open()<CR>')
map("n", "<leader>dt", ':lua require("dapui").toggle()<CR>')
map("n", "<leader>dl", ':lua require("dap").run_last()<CR>')

-- Comments
map("n", "<leader>/", ":CommentToggle<CR>")
map("v", "<leader>/", ":'<,'>CommentToggle<CR>")

-- Code Outline
map("n", "<leader>co", ":SymbolsOutline<CR>")

-- Bufferline mappings
map("n", "<A-a>", ":BufferLineCyclePrev<CR>")
map("n", "<A-s>", ":BufferLineCycleNext<CR>")
map("n", "<A-x>", ":lua require('utils.init').close_buffer()<CR>")

-- Vim Notify Mappings
map("n", "<leader>nv", ":lua require('telescope').extensions.notify.notify()<CR>")
map("n", "<leader>nd", ":lua require('notify').dismiss()<CR>")
