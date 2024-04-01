--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Server                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

  -- Automates a tedious process of configuring every single LSP Server
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",

  dependencies = {

    -- LSP Configuration and Plugins
    { "neovim/nvim-lspconfig" },

    -- Automatically install LSPs
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- Full signature help, docs and completion for the nvim lua API.
    { "folke/neodev.nvim" },

    -- TODO:
    -- I hate needing to be in the window to use trouble,
    -- so I'm propably going to fork it later

    { "folke/trouble.nvim" },
  },

  config = function()
    require("soupvim.plugins.config.lsp")
  end,
}
