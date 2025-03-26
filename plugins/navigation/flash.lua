-- ┌            ┐
-- │ flash.nvim │
-- └            ┘
return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		jump = { autojump = true },
		modes = {
			char = {
				jump_labels = true,
				jump = { autojump = true },
			},
		},
	},
	keys = {
		{
			"<leader>j",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
	},
}
