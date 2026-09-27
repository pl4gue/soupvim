return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
		{
			"<leader>s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					search = {
						mode = function(str)
							return "\\<" .. str
						end,
					},
				})
			end,
			desc = "Flash",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"sd",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump({
					---@param win integer
					matcher = function(win)
						---@param diag vim.Diagnostic
						return vim.tbl_map(function(diag)
							return {
								pos = { diag.lnum + 1, diag.col },
								end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
							}
						end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
					end,
					action = function(match, state)
						vim.api.nvim_win_call(match.win, function()
							vim.api.nvim_win_set_cursor(match.win, match.pos)
							vim.diagnostic.open_float()
						end)
						state:restore()
					end,
					search = {
						mode = function(str)
							return "\\<" .. str
						end,
					},
				})
			end,
			desc = "Flash",
		},
	},
	-- {
	-- 	"n",
	-- 	mode = { "n", "x", "o" },
	-- 	function()
	-- 		require("flash").treesitter({
	-- 			actions = {
	-- 				["n"] = "next",
	-- 				["N"] = "prev",
	-- 			},
	-- 		})
	-- 	end,
	-- 	desc = "Flash Treesitter",
	-- },
}
