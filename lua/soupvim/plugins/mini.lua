return {
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		opts = {
			mappings = {
				around_next = "",
				inside_next = "",
				around_last = "",
				inside_last = "",
			},
		},
	},
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",

					-- Add this only if you don't want to use extended mappings
					suffix_last = "",
					suffix_next = "",
				},
				search_method = "cover_or_next",
			})

			-- Remap adding surrounding to Visual mode selection
			vim.keymap.del("x", "ys")
			vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

			-- Make special mapping for "add surrounding for line"
			vim.keymap.set("n", "yss", "ys_", { remap = true })
		end,
	},
	{ "nvim-mini/mini.pairs", event = "VeryLazy", opts = {} },
	{
		"nvim-mini/mini.sessions",
		opts = {
			hooks = {

				pre = {
					read = function()
						require("soupvim.core.buffers").serialize_state()
					end,
					write = function()
						require("soupvim.core.buffers").serialize_state()
					end,
				},
				post = {
					read = function()
						require("soupvim.core.buffers").hydrate_state()
					end,
					write = function()
						require("soupvim.core.buffers").hydrate_state()
					end,
				},
			},
		},
	},
}
