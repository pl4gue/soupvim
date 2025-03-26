--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                         QuickFix                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local map = vim.keymap.set

return {
	{
		-- auto updating quickfix list
		"onsails/diaglist.nvim",
		keys = {
			{
				"<leader>dw",
				mode = { "n" },
				function()
					require("diaglist").open_all_diagnostics()
				end,
				desc = "Open all diagnostics in quickfix",
			},
			{
				"<leader>d0",
				mode = { "n" },
				function()
					require("diaglist").open_buffer_diagnostics()
				end,
				desc = "Open document diagnostics in quickfix",
			},
		},
	},
	{
		-- better qflist + inline editing
		"stevearc/quicker.nvim",
		event = "FileType qf",
		config = function()
			local quicker = require("quicker")
			map("n", "<leader>q", function()
				quicker.toggle({ focus = true })
				if quicker.is_open() then
					quicker.expand()
				end
			end)

			map("n", "<leader>l", function()
				quicker.toggle({ loclist = true, focus = true })
				if quicker.is_open() then
					quicker.expand()
				end
			end)

			quicker.setup({
				opts = { winfixheight = false },
				borders = {
					vert = "│",

					-- Strong headers separate results from different files
					strong_header = "━",
					strong_cross = "┿",
					strong_end = "┥",
					-- Soft headers separate results within the same file
					soft_header = "─",
					soft_cross = "┼",
					soft_end = "┤",
				},
				keys = {
					{
						">",
						function()
							quicker.expand({ before = 2, after = 2, add_to_existing = true })
						end,
						desc = "Expand quickfix context",
					},
					{
						"<",
						function()
							quicker.collapse()
						end,
						desc = "Collapse quickfix context",
					},
				},
			})

			vim.api.nvim_set_hl(0, "QuickFixLine", { link = "Visual" })
			vim.api.nvim_set_hl(0, "QuickFixLineNr", { link = "Comment" })
		end,
	},
}
