--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Config                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local map = function(mode, bind, func)
  vim.keymap.set(mode, bind, func, { buffer = bufnr, remap = false })
end

-- ─[ Neodev ]─────────────────────────────────────────────────────────
--
-- Full signature help, docs and completion for the nvim lua API.

require("neodev").setup({})

-- ─[ LspZero ]────────────────────────────────────────────────────────
--
-- Automates a tedious process of configuring every single LSP Server

local lsp = require("lsp-zero")

-- ─[ Trouble ]────────────────────────────────────────────────────────
--
-- Pretty list of diagnostics, telescope, quickfix, etc.

local trouble = require("trouble")
trouble.setup({
  icons = false,
  fold_open = "v",
  fold_closed = ">",
  indent_lines = false,
  signs = {
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = false,
  auto_preview = false,
})

local trouble_jump = function(fn)
  trouble[fn]({ skip_groups = true, jump = true })
  vim.diagnostic.show()
end

map("n", "<Leader>tt", trouble.toggle)
map("n", "<Leader>tq", function() trouble.toggle("quickfix") end)
map("n", "<Leader>tw", function() trouble.toggle("workspace_diagnostics") end)

-- ─[ Keymaps ]────────────────────────────────────────────────────────
--
-- gd          -> Go to definition
-- K           -> Hover
-- <Leader>vws -> Workspace Symbols
-- <Leader>vd  -> Open diagnostic in float
-- <Leader>vca -> Code Actions
-- <Leader>vrr -> Reference List
--
-- [d          -> Go to previous diagnostic in trouble
-- ]d          -> Go to next diagnostic in trouble
--
-- <Leader>vrn -> Rename object
-- <C-h>       -> Signature help
-- <Leader>f   -> Format file

lsp.on_attach(function(_, _)
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<Leader>vws", vim.lsp.buf.workspace_symbol)
  map("n", "<Leader>vd", vim.diagnostic.open_float)
  map("n", "<Leader>vca", vim.lsp.buf.code_action)
  map("n", "<Leader>vrr", vim.lsp.buf.references)

  map("n", "[d", function() trouble_jump("previous") end)
  map("n", "]d", function() trouble_jump("next") end)

  map("n", "<Leader>vrn", vim.lsp.buf.rename)
  map({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help)
  map("n", "<Leader>f", vim.lsp.buf.format)
end)

lsp.setup()

-- ─[ LSP servers config ]─────────────────────────────────────────────

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls" },
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
  },
})
