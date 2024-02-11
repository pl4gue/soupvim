--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Config                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

-- Neodev
-- Full signature help, docs and completion for the nvim lua API.

require('neodev').setup({})

-- LspZero 
-- Automates a tedious process of configuring every single LSP Server

local lsp = require('lsp-zero')

-- Sets LSP keymaps

lsp.on_attach(function(_, bufnr)
  local map = function (mode, bind, func)
    vim.keymap.set(mode, bind, func, {buffer = bufnr, remap = false})
  end

  map('n', 'gd', function () vim.lsp.buf.definition() end)
  map('n', 'K', function () vim.lsp.buf.hover() end)
  map('n', '<Leader>vws', function () vim.lsp.buf.workspace_symbol() end)
  map('n', '<Leader>vd', function () vim.diagnostic.open_float() end)
  map('n', '[d', function () vim.diagnostic.definition() end)
  map('n', ']d', function () vim.diagnostic.definition() end)
  map('n', '<Leader>vca', function () vim.lsp.buf.code_action() end)
  map('n', '<Leader>vrr', function () vim.lsp.buf.references() end)
  map('n', '<F2>', function () vim.lsp.buf.rename() end)
  map('n', '<C-h>', function () vim.lsp.buf.signature_help() end)
  map('n', '<Leader>f', function () vim.lsp.buf.format() end)
end)


-- Automatic setup of LSP servers

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'clangd', 'lua_ls',},
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


-- Autocompletion

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({

    -- Enter or Tab to complete
    -- If Enter is pressed but none item is selected then it's a new line.
    -- If Tab is pressed but none item is selected then it autocompletes.

    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp.mapping.confirm({select = true}),

    -- Ctrl+j or k will move the items, arrows up and down also works.
    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

    -- Ctrl+Space or Ctril+i to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-i>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),

  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'buffer', },
    { name = 'calc', },
    {
      name = 'path',
      option = {
        trailing_slash = true,
        label_trailing_slash = true,
      } 
    },
  },

  experimental = {
    -- Adds ghost text under cursor on suggestion.
    ghost_text = true
  }
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
