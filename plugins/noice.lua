return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline",
			format = {
				-- My own inc_rename because I dislike the title of default ngl
				rename = {
					view = "cmdline_popup",
					pattern = "^:%s*IncRename%s+",
					icon = " ",
					conceal = true,
					opts = {
						relative = "cursor",
						size = { min_width = 24 },
						position = { row = -3, col = 0 },
						border = {
							style = vim.o.winborder,
							text = {
								top_align = "left",
							},
						},
					},
				},
			},
		},
		notify = { view = "notify" },
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			signature = {
				enabled = false,
			},
			hover = { silent = true },
		},
		-- you can enable a preset for easier configuration
		presets = { long_message_to_split = true },
		health = { checker = false },

		routes = {
			filter = {
				event = "msg_show",
				find = "vim.pack",
			},
		},
	},
	-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	dependencies = {
		{ "MunifTanjim/nui.nvim", main = "nui" },
	},
}
