return {
	-- Adds cools signs in the sign column,
	-- also has a inline blame virtual text.

	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "│" },
			delete = { text = "", show_count = true },
			topdelete = { text = "‾", show_count = true },
			changedelete = { text = "~", show_count = true },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "│" },
			delete = { text = "", show_count = true },
			topdelete = { text = "‾", show_count = true },
			changedelete = { text = "~", show_count = true },
			untracked = { text = "┆" },
		},

		diffthis = { unified = true },

		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 500,
			ignore_whitespace = false,
		},

		current_line_blame_formatter = "[<abbrev_sha>] '<summary>', <author> (<author_time:%d-%m-%Y>)",

		preview_config = {
			row = -1,
			col = 2,
		},
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, silent = true })
			end

			map({ "n", "x" }, "<leader>hs", gitsigns.stage_hunk, "Stage Hunk")
			map({ "n", "x" }, "<leader>hr", gitsigns.reset_hunk, "Reset Hunk")
			map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
			map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")

			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Visual Stage Hunk")

			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Visual Reset Hunk")

			map("n", "<leader>hp", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
			map("n", "<leader>hd", gitsigns.diffthis, "Diffthis")
			map("n", "<leader>hdp", function()
				gitsigns.diffthis("~")
			end, "Diffthis ~")

			map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word diff")
		end,
	},
}
