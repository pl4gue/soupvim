return {
	"fnune/recall.nvim",
	opts = {
		{
			sign = "",
			wshada = vim.version.cmp(vim.version(), { 0, 10, 0 }) >= 0,
		},
	},

	keys = {
		{ "<C-s>", ":RecallToggle<CR>" },
		{ "<C-'>", ":RecallNext<CR>" },
		{ "<C-S-'>", ":RecallPrev<CR>" },
	},
}
