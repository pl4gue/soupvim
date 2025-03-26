--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Dashboard                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("soupvim.plugins.ui.dashboard.alpha")
	end,
}
