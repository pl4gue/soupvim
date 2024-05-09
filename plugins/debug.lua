--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │               Debugger Analyser Protocol                 │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },

  config = function()
    require("soupvim.plugins.config.debug")
  end,
}
