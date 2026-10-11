-- vim.g.markview_blink_loaded = true

return {
	"obsidian-nvim/obsidian.nvim",
    ft = "md",
	cond = soupvim.is_cwd_inside(soupvim.OBSIDIAN_VAULT_LOCATION),
	dependencies = { "noisesfromspace/touchup.nvim", opts = {} },
	opts = {
		legacy_commands = false, -- this will be removed in 4.0.0
		picker = {
			name = "fzf-lua",
		},
		workspaces = {
			{
				name = "soupsidian",
				path = soupvim.OBSIDIAN_VAULT_LOCATION,
			},
		},
	},
}
