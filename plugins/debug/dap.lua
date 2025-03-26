--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                     Debugging Config                     │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local dap, dapui = require("dap"), require("dapui")

-- Language Specific Setups
require("dap-go").setup() -- Golang

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/home/plague/.local/share/nvim/mason/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}

dap.configurations.c = dap.configurations.cpp

-- Keymaps
local map = vim.keymap.set
map("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggles breakpoint" })
map("n", "<Leader>dc", dap.continue, { desc = "Toggles breakpoint" })

-- DapUI Config
dapui.setup()

-- Opens dap-ui autommatically
local open_dapui = function()
  dapui.open()
end

dap.listeners.before.attach.dapui_config = open_dapui
dap.listeners.before.launch.dapui_config = open_dapui

-- Closes dap-ui autommatically
local close_dapui = function()
  dapui.close()
end

dap.listeners.before.event_terminated.dapui_config = close_dapui
dap.listeners.before.event_exited.dapui_config = close_dapui
