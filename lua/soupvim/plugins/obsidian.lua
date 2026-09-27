return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
		},

		opts = {
			legacy_commands = false,

			workspaces = {
				{
					name = "soupsidian",
					path = "~/docs/soupsidian/",
				},
			},

			ui = {
				enable = false,
			},

			picker = {
				name = "fzf-lua",
			},

			templates = {
				folder = "_meta/templates",
			},
		},
		keys = {
			{
				"<CR>",
				function()
					return require("obsidian").util.smart_action()
				end,
				buffer = true,
				expr = true,
			},
			{
				"gf",
				function()
					return require("obsidian").util.gf_passthrough()
				end,
				noremap = false,
				expr = true,
				buffer = true,
			},
		},
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",

		opts = {
			completions = {
				blink = {
					enabled = false,
				},

				lsp = {
					enabled = true,
				},
			},
		},
	},
}
