--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Config                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local lsp = require("soupvim.api.lsp")

lsp.setup_capabilities()

-- ─[ Keymaps ]────────────────────────────────────────────────────────
--
-- <Leader>ws  -> [W]orkspace [S]ymbols (telescope)
-- <Leader>ds  -> [D]ocument [S]ymbols (telescope)
-- <Leader>gd  -> [G]oto [D]efinition (telescope)
-- <Leader>gi  -> [G]oto [I]mplementation (telescope)
-- <Leader>gr  -> [G]oto [R]eference (telescope)
-- <Leader>td  -> [T]ype [D]efinition (telescope)
--
-- [d          -> Go to previous diagnostic in workspace
-- ]d          -> Go to next diagnostic in workspace
-- <Leader>fd  -> [F]ind workspace [D]iagnostics (telescope)
-- <Leader>vd  -> [V]iew [D]iagnostic in float
--
-- K           -> Hover
-- <Leader>ca  -> [C]ode [A]ctions
-- <C-h>       -> Signature help
-- <Leader>f   -> Format file

lsp.on_attach(function(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	local no_trouble = require("soupvim.plugins.lsp.no-trouble")
	local telescope = require("telescope.builtin")

	require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

	map("n", "<Leader>ws", telescope.lsp_workspace_symbols, "[W]orkspace [S]ymbols (telescope)")
	map("n", "<Leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols (telescope)")
	map("n", "<Leader>gd", telescope.lsp_definitions, "[G]oto [D]efinition (telescope)")
	map("n", "<Leader>gi", telescope.lsp_implementations, "[G]oto [I]mplementation (telescope)")
	map("n", "<Leader>gr", telescope.lsp_references, "[G]oto [R]eference (telescope)")
	map("n", "<Leader>td", telescope.lsp_type_definitions, "[T]ype [D]efinition (telescope)")

	map("n", "[d", no_trouble.actions.prev, "Go to previous diagnostic in workspace (no-trouble)")
	map("n", "]d", no_trouble.actions.next, "Go to next diagnostic in workspace (no-trouble)")
	map("n", "<Leader>fd", telescope.diagnostics, "[F]ind workspace [D]iagnostics (telescope)")
	map("n", "<Leader>vd", vim.diagnostic.open_float, "[V]iew [D]iagnostic in float")

	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions")

	map({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, "Signature help")
	map("n", "<Leader>f", vim.lsp.buf.format, "Format file")

	if client:supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end)

-- ─[ LSP servers config ]─────────────────────────────────────────────

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "lua_ls", "bashls" },
	handlers = {
		lsp.default_setup,

		--[[
        If you need to configure a language server installed by mason.nvim,
        add a "handler function" to the handlers option. Something like this:

        server_name = function()
          require('lsp-config').server_name.setup({
            -- Add your custom config here
          })
        end,
    ]]

		lua_ls = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						hint = {
							enable = true,
							arrayIndex = "Disable",
							paramName = "Disable",
							setType = true,
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			})
		end,
	},
})

-- ─[ Diagnostics ]─────────────────────────────────────────────

require("dd").setup()
require("lsp_lines").setup()
vim.diagnostic.config({ virtual_text = false })
