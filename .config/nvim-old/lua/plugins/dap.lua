local present, dap = pcall(require, "dap")
if not present then
    return
end

-- dap-ui configurations
require("dapui").setup({})

vim.fn.sign_define('DapBreakpoint', {text='● ', texthl='DiagnosticSignError', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='● ', texthl='DiagnosticSignWarn', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='● ', texthl='DiagnosticSignInfo', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='→ ', texthl='DiagnosticSignWarn', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointReject', {text='●' , texthl='DiagnosticSignHint', linehl='', numhl=''})
