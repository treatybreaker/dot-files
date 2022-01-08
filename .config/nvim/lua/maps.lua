-- Function for make mapping easier.
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Map leader key to space.
vim.g.mapleader = " "


-- Set cl for clearing highlights after searching word in file.
map("n", "cl", ":noh<CR>")


-- Split navigations.
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")


-- Buffer resizing.
map("n", "<S-h>", ":call ResizeLeft(3)<CR><Esc>")
map("n", "<S-l>", ":call ResizeRight(3)<CR><Esc>")
map("n", "<S-k>", ":call ResizeUp(1)<CR><Esc>")
map("n", "<S-j>", ":call ResizeDown(1)<CR><Esc>")


-- Buffer switching.
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
map("n", "<Tab>", ":BufferLineCycleNext<CR>")

-- Buffer closing.
map("n", "<leader>bc", ":lua require('functions').close_buffer()<CR>")

-- Buffer moving.
map("n", "<leader>bl", ":BufferLineMoveNext<CR>")
map("n", "<leader>bh", "::BufferLineMovePrev<CR>")


-- Filetree toggle
map("n", "<leader>nt", ":NvimTreeToggle<CR>")


-- Telescope
map("n", "<Leader>tw", ":Telescope live_grep<CR>")
map("n", "<Leader>gs", ":Telescope git_status<CR>")
map("n", "<Leader>gc", ":Telescope git_commits<CR>")
map("n", "<Leader>gb", ":Telescope git_branches<CR>")
map("n", "<Leader>tf", ":Telescope find_files find_command=rg,--follow,--hidden,--files<CR>")
map("n", "<Leader>td", ":Telescope find_directories<CR>")
map("n", "<Leader>tp", ":Telescope media_files<CR>")
map("n", "<Leader>tb", ":Telescope buffers<CR>")
map("n", "<Leader>th", ":Telescope help_tags<CR>")
map("n", "<Leader>to", ":Telescope oldfiles<CR>")
map("n", "<Leader>tt", ":Telescope treesitter<CR>")
map("n", "<leader>tc", ":Telescope neoclip default<CR>")
map("n", "<leader>tr", ":Telescope registers<CR>")


-- Lsp
local lsp_opts = { noremap=true, silent=true }
map("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", lsp_opts)
map("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", lsp_opts)
map("n", "<leader>k", ":lua vim.lsp.buf.hover()<CR>", lsp_opts)
map("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", lsp_opts)
map("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", lsp_opts)
map("n", "<leader>la", ":lua vim.lsp.buf.add_workspace_folder()<CR>", lsp_opts)
map("n", "<leader>lx", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", lsp_opts)
map("n", "<leader>ll", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", lsp_opts)
map("n", "<leader>lT", ":lua vim.lsp.buf.type_definition()<CR>", lsp_opts)
map("n", "<leader>ln", ":lua vim.lsp.buf.rename()<CR>", lsp_opts)
map("n", "<leader>lc", ":lua vim.lsp.buf.code_action()<CR>", lsp_opts)
map("n", "<leader>lr", ":lua vim.lsp.buf.references()<CR>", lsp_opts)
map("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", lsp_opts)
map("n", "[", ":lua vim.diagnostic.goto_prev()<CR>", lsp_opts)
map("n", "]", ":lua vim.diagnostic.goto_next()<CR>", lsp_opts)
map("n", "<leader>lq", ":Telescope diagnostics bufnr=0<CR>", lsp_opts)


-- Dap
map("n", "<leader>dR", ":lua require(\"dap\").continue()<CR>")
map("n", "<leader>de", ":lua require(\"dap\").terminate()<CR>")
map("n", "<leader>db", ":lua require(\"dap\").toggle_breakpoint()<CR>")
map("n", "<leader>dr", ":lua require(\"dap\").set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<leader>dp", ":lua require(\"dap\").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<F5>", ":lua require(\"dap\").step_over()<CR>")
map("n", "<F6>", ":lua require(\"dap\").step_into()<CR>")
map("n", "<F7>", ":lua require(\"dap\").step_out()<CR>")
map("n", "<leader>dB", ":lua require(\"dap\").step_back()<CR>")
map("n", "<leader>dc", ":lua require(\"dap\").run_to_cursor()<CR>")
map("n", "<leader>do", ":lua require(\"dap\").repl.open()<CR>")
map("n", "<leader>dt", ":lua require(\"dapui\").toggle()<CR>")
map("n", "<leader>dl", ":lua require(\"dap\").run_last()<CR>")


-- ToggleTerm
map("n", "<C-t>", ":ToggleTerm dir=%:p:h<CR>")
map("t", "<C-t>", ":ToggleTerm dir=%:p:h<CR>")
map("n", "v:count1 <C-t>", ":v:count1" .. "\"ToggleTerm\"<CR>")
map("v", "v:count1 <C-t>", ":v:count1" .. "\"ToggleTerm\"<CR>")
function _G.set_terminal_keymaps()
  map("t", "<esc>", "<C-\\><C-n>")
  map("t", "<C-h>", "<c-\\><c-n><c-w>h")
  map("t", "<C-j>", "<c-\\><c-n><c-w>j")
  map("t", "<C-k>", "<c-\\><c-n><c-w>k")
  map("t", "<C-l>", "<c-\\><c-n><c-w>l")

  map("t", "<S-h>", "<c-\\><C-n>:call ResizeLeft(3)<CR>")
  map("t", "<S-j>", "<c-\\><C-n>:call ResizeDown(1)<CR>")
  map("t", "<S-k>", "<c-\\><C-n>:call ResizeUp(1)<CR>")
  map("t", "<S-l>", "<c-\\><C-n>:call ResizeRight(3)<CR>")
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")


-- Remove unnecessary white spaces.
map("n", "<leader>cw", ":StripWhitespace<CR>")


-- comment
map("n", "<leader>/", ":CommentToggle<CR>")
map("v", "<leader>/", ":'<,'>CommentToggle<CR>")


-- Code formatter.
map("n", "<leader>fr", ":Neoformat<CR>", lsp_opts)

-- Searchbox.nvim
map("n", "<leader>sf", ":SearchBoxIncSearch<CR>")
map("n", "<leader>sF", ":SearchBoxIncSearch reverse=true<CR>")
map("n", "<leader>sr", ":SearchBoxReplace<CR>")

-- Cheatsheet.nvim
map("n", "<leader>?", ":Cheatsheet<CR>")
