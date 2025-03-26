--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                         FileTree                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local map = vim.keymap.set

return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = { show_hidden = true },
			float = { border = "single" },
			keymaps = { ["q"] = "actions.close" },
		})

		map("n", "-", require("oil").toggle_float, { desc = "Open parent directory" })
	end,
}
