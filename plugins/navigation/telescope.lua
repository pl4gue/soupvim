--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Telescope                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯
local map = vim.keymap.set

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = (vim.fn.executable("make") == 1) },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			-- Key Bindings
			map("n", "<Leader>ff", builtin.find_files, {})
			map("n", "<Leader>fg", builtin.live_grep, {})
			map("n", "<Leader>fb", builtin.buffers, {})
			map("n", "<Leader>fh", builtin.help_tags, {})
			map("n", "<Leader>fc", "<cmd>Telescheme<cr>", {})

			-- Telescope Setup
			telescope.setup({
				defaults = {
					dynamic_preview_title = true,
					prompt_prefix = "   ",
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
					-- set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default is "smart_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({ layout_strategy = "cursor" }),
					},
				},
			})

			-- Extensions
			telescope.load_extension("fzf") -- NOTE: Could try fzy later
			telescope.load_extension("ui-select")
			telescope.load_extension("track")
		end,
	},
}
