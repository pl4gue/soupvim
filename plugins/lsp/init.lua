--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Server                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

	-- LSP Configuration and Plugins
	"neovim/nvim-lspconfig",
	dependencies = {

		-- LSP Installation
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- LSP lines that tell you what exactly is wrong
		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
		{ "https://gitlab.com/yorickpeterse/nvim-dd.git" },

		-- Loads workspace diagnostics on attach
		{ "artemave/workspace-diagnostics.nvim" },

		-- Automatically enables inlay hints
		-- { "MysticalDevil/inlay-hints.nvim", opts = { autocmd = { enable = true } } },

		-- Full signature help, docs and completion for the nvim lua API.
		{ "folke/lazydev.nvim", opts = {} },

		-- List diagnostics and others
		{ "folke/trouble.nvim", opts = { auto_preview = false } },

		--- HACK:
		--- My plugin navigates diagnostics better 😎

		{ "pl4gue/no-trouble.nvim" },
	},

	config = function()
		require("soupvim.plugins.lsp.lspconfig")
	end,
}
