--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Treesitter                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	dependencies = {
		-- 'nvim-treesitter/nvim-treesitter-textobjects',
		"RRethy/nvim-treesitter-textsubjects",
	},

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go" },
			sync_install = false,

			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			textsubjects = {
				enable = true,
				prev_selection = ",", -- (Optional) keymap to select the previous selectiontree
				keymaps = {
					[",<Leader>"] = {
						"textsubjects-smart",
						desc = "Select smartly containers (comments, functions, loops, statements, etc.)",
					},
					["a<Leader>"] = {
						"textsubjects-container-outer",
						desc = "Select inside containers (classes, functions, etc.)",
					},
					["i<Leader>"] = {
						"textsubjects-container-inner",
						desc = "Select inside containers (classes, functions, etc.)",
					},
				},
			},
		})
	end,
}
