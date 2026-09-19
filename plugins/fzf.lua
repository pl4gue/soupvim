return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		opts = {
			"borderless-full",
			"hide",
		},
		keys = {
			{ "<leader><space>", ":FzfLua global<CR>", { desc = "Find Files" } },
			{ "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" } },
			{ "<leader>fr", ":FzfLua oldfiles<CR>", { desc = "Find Files" } },
			{ "<leader>fw", ":FzfLua live_grep<CR>", { desc = "Find Files" } },
			{ "<leader>fW", ":FzfLua grep_cWORD<CR>", { desc = "Find Files" } },
		},
	},
}
