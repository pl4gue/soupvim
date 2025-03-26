-- ┌            ┐
-- │ noice.nvim │
-- └            ┘

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline_popup",
			opts = {
				position = {
					row = "30%",
					col = "50%",
				},
				border = {
					style = "single",
				},
			},
		},
		notify = { view = "mini" },
		popupmenu = { enabled = false },
		lsp = {
			progress = {
				format_done = {
					{ " ", hl_group = "NoiceLspProgressSpinner" },
					{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
					{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
				},
			},
			hover = { enabled = false },
			signiature = { enabled = false, auto_open = { enabled = false } },
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = { view = "mini", filter = { event = "msg_showmode" } },
		presets = {
			inc_rename = {
				cmdline = {
					format = {
						IncRename = {
							opts = {
								position = { row = -2, col = -3 },
							},
						},
					},
				},
			},
		},
	},
}
