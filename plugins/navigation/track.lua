-- ┌            ┐
-- │ track.nvim │
-- └            ┘
return {
	"dharmx/track.nvim",
	config = function()
		local set = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { silent = true })
		end

		local track_util = require("track.util")

		local index = 1

		local function prevMark()
			local _, branch = track_util.root_and_branch()
			if not branch then
				return
			end

			index = (index == 1) and #branch.views or (index - 1)
			vim.cmd.OpenMark(index)
		end

		local function nextMark()
			local _, branch = track_util.root_and_branch()
			if not branch then
				return
			end

			index = (index == #branch.views) and 1 or (index + 1)
			vim.cmd.OpenMark(index)
		end

		set("n", "<leader>hh", "<cmd>Track<cr>")
		set("n", "<leader>ha", "<cmd>Mark<cr><cmd>Track save<cr>")
		set("n", "<leader>hr", "<cmd>Unmark<cr><cmd>Track save<cr>")
		set("n", "<M-,>", prevMark)
		set("n", "<M-.>", nextMark)

		local save_and_close = function(self)
			self:sync(true)
			self:close()
		end

		require("track").setup({
			pad = {
				save_on_close = true,
				serial_map = true,
				mappings = {
					n = {
						q = save_and_close,
						["<Esc>"] = save_and_close,
						["<leader>hh"] = save_and_close,
					},
				},
				config = {
					border = "single",
					width = 50,
					height = 8,
				},
			},
		})
	end,
}
