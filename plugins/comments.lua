--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Comments                          │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local map = vim.keymap.set

return {
	{ "LudoPinelli/comment-box.nvim" },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup({
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO", "HINT" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
					UNUSED = { icon = "󰀩", color = "warning" },
				},
				highlight = {
					pattern = {
						[[.*<(KEYWORDS)\s*:]],
					}, -- pattern used for highlightng (vim regex)
				},
				search = {
					pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})

			map("n", "]t", todo.jump_next, { desc = "Next todo comment" })
			map("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })
		end,
	},
}
