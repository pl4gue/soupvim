--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Server                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

  -- Automates a tedious process of configuring every single LSP Server
  'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',

  dependencies = {

    -- LSP Configuration and Plugins
    {'neovim/nvim-lspconfig'},

    -- Automatically install LSPs
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP Completion
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},

    {'hrsh7th/cmp-buffer'}, -- buffer word completion
    {'hrsh7th/cmp-cmdline'}, -- cmdline completion
    {'hrsh7th/cmp-path'}, -- file path completion
    {'hrsh7th/cmp-calc'}, -- math calculation completion
    {'hrsh7th/cmp-latex-symbols'}, -- latex symbols completion

    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      build = function ()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 then
          return
        end
        return 'make install_jsregexp'
      end
  },

    -- Full signature help, docs and completion for the nvim lua API.
    {'folke/neodev.nvim'}
  },

  -- All LSP configs
  config = function()
    require'soupvim.plugins.config.lsp'
  end
}
