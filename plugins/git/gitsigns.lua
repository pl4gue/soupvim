--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                      Gitsigns Config                     │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "│" },
		delete = { text = "-" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},

	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

	watch_gitdir = { follow_files = true },
	auto_attach = true,
	attach_to_untracked = false,

	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 500,
		ignore_whitespace = false,
	},

	current_line_blame_formatter = "[<abbrev_sha>] '<summary>', <author> (<author_time:%d-%m-%Y>)",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)

	preview_config = {
		-- Options passed to nvim_open_win
		border = "rounded",
		relative = "cursor",
		style = "minimal",
		row = -1,
		col = 2,
	},
})
