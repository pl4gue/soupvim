return {
	"XXiaoA/ns-textobject.nvim",
	opts = {},
	dependencies = {
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = { aliases = { ["a"] = false, ["b"] = "}", ["r"] = false }, move_cursor = "sticky" },
	},
}
