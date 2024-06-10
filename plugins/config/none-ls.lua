--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │               Linters and Formatters Config              │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

-- ─[ LSP Servers Auto Installation ]──────────────────────────────────
--
-- This config automatically installs LSP Servers.

local lsp = require("lsp-zero")
require("mason-null-ls").setup({
  methods = {
    diagnostics = true,
    formatting = true,
    code_actions = true,
    completion = true,
    hover = true,
  },
  ensure_installed = {},
  automatic_installation = true,
  handlers = {},
})

-- ─[ null_ls ]────────────────────────────────────────────────────────
--
-- Configures the defaults of lsp-zero for null_ls
-- and enables formatting on save.

local null_ls = require("null-ls")

local null_opts = lsp.build_options("null-ls", {
  on_attach = function(client, bufnr)
    local format_on_save = vim.api.nvim_create_augroup("LspFormatting", {})

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_on_save,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- ─[ null_ls sources ]────────────────────────────────────────────────
--
-- Sources and configures the linters and formatters.

local sources = {
  -- Lua
  null_ls.builtins.formatting.stylua, -- Lua formatting

  -- Web Languages
  -- null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.prettierd,

  -- Golang
  null_ls.builtins.formatting.gofumpt,           -- Go formatting
  null_ls.builtins.formatting.goimports_reviser, -- Autoimporting
  null_ls.builtins.formatting.golines,           -- Formats imports

  -- Shell Languages
  null_ls.builtins.code_actions.bashls,

  -- Python
  null_ls.builtins.formatting.black
}

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
  end,
  sources = sources,
})
