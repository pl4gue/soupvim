return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		messages = {
			view_error = "messages",
		},
		popupmenu = { enabled = false },
		cmdline = {
			view = "cmdline",
			format = {
				input = {
					view = "cmdline",
				},
			},
		},
		notify = { view = "notify" },
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			signature = { enabled = true },
			hover = { silent = true },
		},
		-- you can enable a preset for easier configuration
		-- presets = { long_message_to_split = true },
		health = { checker = false },

		routes = {
			filter = {
				event = "msg_show",
				find = "vim.pack",
			},
		},
	},
	dependencies = {
		{ "MunifTanjim/nui.nvim", main = "nui" },
	},
}
