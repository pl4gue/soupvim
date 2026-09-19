return {
	"jay-babu/mason-null-ls.nvim",
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"stylua",
		},
	},

	dependencies = {
		{ "mason-org/mason.nvim", event = "VeryLazy", opts = {} },
		{
			"nvimtools/none-ls.nvim",
			event = "VeryLazy",
			main = "null-ls",
			opts = {
				on_attach = function(client, bufnr)
					local group = vim.api.nvim_create_augroup("LspFormatting", {})

					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = group,
							buffer = bufnr,
						})

						vim.api.nvim_create_autocmd("BufWritePre", {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			},
		},

		{
			"zeioth/none-ls-autoload.nvim",
			event = "VeryLazy",
			opts = {},
		},
	},
}
