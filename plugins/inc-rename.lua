return {
	"smjonas/inc-rename.nvim",
	opts = { input_buffer_type = "noice" },
	cmd = "IncRename",
	keys = {
		"<leader>rn",
		function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end,
		mode = "n",
		expr = true,
	},
}
