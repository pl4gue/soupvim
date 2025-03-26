return {
	"declancm/cinnamon.nvim",
	version = "*", -- use latest release
	config = function()
		local cinnamon = require("cinnamon")
		cinnamon.setup({
			keymaps = {
				basic = true,
			},
			options = {
				mode = "cursor",
				max_delta = {
					column = 0, -- disables horizontal smooth scrolling
					time = 250,
				},
			},
		})

		local map = vim.keymap.set

		map("n", "j", function()
			cinnamon.scroll("j")
		end)
		map("n", "k", function()
			cinnamon.scroll("k")
		end)

		-- Centered scrolling
		map("n", "<C-U>", function()
			cinnamon.scroll("<C-U>zz")
		end)
		map("n", "<C-D>", function()
			cinnamon.scroll("<C-D>zz")
		end)

		map("n", "gg", function()
			cinnamon.scroll("gg")
		end)
		map("n", "G", function()
			cinnamon.scroll("G")
		end)

		map("n", "<C-E>", function()
			cinnamon.scroll("<C-E>", { mode = "window" })
		end)
		map("n", "<C-Y>", function()
			cinnamon.scroll("<C-Y>", { mode = "window" })
		end)
	end,
}
