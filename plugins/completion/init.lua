--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                     Auto-Completion                      │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol" },

		{ "hrsh7th/cmp-buffer" }, -- buffer word completion
		{ "hrsh7th/cmp-cmdline" }, -- cmdline completion
		{ "hrsh7th/cmp-path" }, -- file path completion
		{ "hrsh7th/cmp-calc" }, -- math calculation completion
		{ "hrsh7th/cmp-latex-symbols" }, -- latex symbols completion

		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},

		{ "lukas-reineke/cmp-under-comparator" }, -- better sort completion items

		{ "onsails/lspkind.nvim" },
		{ "xzbdmw/colorful-menu.nvim", opts = { max_width = 30 } },

		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				-- "rafamadriz/friendly-snippets",
			},
			build = function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 then
					return
				end
				return "make install_jsregexp"
			end,
		},
	},

	config = function()
		require("soupvim.plugins.completion.cmp")
	end,
}
