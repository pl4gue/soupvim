--  │                                                          │
--  │                      User Interface                      │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local map = vim.keymap.set

return {

	-- ┌       ┐
	-- │ Noice │
	-- └       ┘

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = require("soupvim.plugins.config.noice"),
		dependencies = { "MunifTanjim/nui.nvim" },
	},

	-- ┌           ┐
	-- │ DashBoard │
	-- └           ┘

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("soupvim.plugins.config.alpha")
		end,
	},

	-- ┌          ┐
	-- │ Comments │
	-- └          ┘

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
				},
				highlight = {
					pattern = { [[.*<(KEYWORDS)\s*:]], [[.*\@(KEYWORDS)\s*]] }, -- pattern used for highlightng (vim regex)
				},
				search = {
					pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})

			map("n", "]t", todo.jump_next, { desc = "Next todo comment" })
			map("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })
		end,
	},

	-- ┌          ┐
	-- │ Zen Mode │
	-- └          ┘

	{
		"Pocco81/true-zen.nvim",
		dependencies = { "folke/twilight.nvim" },
		config = function()
			local zen = require("true-zen")

			zen.setup({
				integrations = {
					kitty = {
						enabled = true, -- Disable if not on Kitty
						font = "+3",
					},
					twilight = true,
				},
			})

			map("n", "<Leader>te", zen.ataraxis)
			map("v", "<Leader>zm", function()
				zen.narrow(vim.fn.line("v"), vim.fn.line("."))
			end)
		end,
	},

	-- ┌          ┐
	-- │ UndoTree │
	-- └          ┘

	{
		"mbbill/undotree",
		config = function()
			map("n", "<Leader>u", function()
				vim.cmd.UndotreeToggle()
				vim.cmd.UndotreeFocus()
			end, { desc = "Toggles UndoTree" })
		end,
	},

	-- ┌          ┐
	-- │ Oil Tree │
	-- └          ┘

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				default_file_explorer = false,
				view_options = { show_hidden = true },
			})

			map("n", "-", require("oil").open, { desc = "Open parent directory" })
		end,
	},
}
