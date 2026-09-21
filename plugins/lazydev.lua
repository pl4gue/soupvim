return {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
	opts = {
		library = {
			"~/.config/nvim/lua/soupvim/",
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "snacks.nvim", words = { "Snacks" } },

			"${3rd}/busted/library",
		},
		enabled = function(_)
			return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
		end,
	},
}
