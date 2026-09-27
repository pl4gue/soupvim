return {
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		config = function()
			local fzf = require("fzf-lua")
			fzf.setup({
				"telescope",
				fzf_opts = {
					["--layout"] = "default", -- keeps prompt/input on top depending on fzf version, or use reverse/default
					["--ansi"] = false,
				},
				winopts = {
					preview = { default = "bat_native" },
				},
			})
			require("fzf-lua").register_ui_select()
		end,
		keys = {
			{ "<leader><space>", ":FzfLua global<CR>", { desc = "Smart Find" } },
			{ "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" } },
			{ "<leader>fF", ":FzfLua git_files<CR>", { desc = "Find Files" } },
			{ "<leader>fb", ":FzfLua buffers<CR>", { desc = "Find Buffers" } },
			{ "<leader>fr", ":FzfLua oldfiles<CR>", { desc = "Recent Files" } },
			{ "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Live Grep" } },
			{ "<leader>fw", ":FzfLua grep_cWORD<CR>", { desc = "Grep WORD under cursor" } },
			{ "<leader>fW", ":FzfLua grep_cWORD<CR>", { desc = "Grep WORD under cursor" } },
		},
	},
}
