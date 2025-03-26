--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                  Linters and Formatters                  │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },

		dependencies = {
			"nvimtools/none-ls.nvim",
			{ "zeioth/none-ls-autoload.nvim", event = { "BufEnter" } },
		},

		config = function()
			require("soupvim.plugins.linting.none-ls")
		end,
	},
	{
		"Wansmer/treesj",
		keys = { "<leader>m", "<leader>M" },
		config = function()
			require("treesj").setup({ use_default_maps = false })

			-- For default preset
			vim.keymap.set("n", "<leader>m", require("treesj").toggle)

			-- For extending default preset with `recursive = true`
			vim.keymap.set("n", "<leader>M", function()
				require("treesj").toggle({ split = { recursive = true } })
			end)
		end,
	},
}
