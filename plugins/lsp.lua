--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Server                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
  'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
  dependencies = {
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'folke/neodev.nvim'}
  },

  config = function()
    require('neodev').setup({})

    local lsp = require('lsp-zero')

    lsp.on_attach(function(_, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {},
      handlers = {
        lsp.default_setup,

        --[[

            If you need to configure a language server installed by mason.nvim,
            add a "handler function" to the handlers option. Something like this:

            example_server = function()
              require('lsp-config').example_server.setup({

                -- Add your custom config here

              })
            end,

        ]]
      }
    })

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      })
    })

  end
}
