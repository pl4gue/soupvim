return {
	"ibhagwan/fzf-lua",
	lazy = true,
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
            { "telescope", "max-perf", "hide"},

			fzf_opts = {
				["--layout"] = "reverse", -- keeps prompt/input on top depending on fzf version, or use reverse/default
			},
			winopts = {
				preview = { default = "bat_native" },
			},
			oldfiles = { include_current_session = true, },
			previewers = {
				builtin = {
					-- fzf-lua is very fast, but it really struggled to preview a couple files
					-- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
					-- It turns out it was Treesitter having trouble parsing the files.
					-- With this change, the previewer will not add syntax highlighting to files larger than 100KB
					-- (Yes, I know you shouldn't have 100KB minified files in source control.)
					syntax_limit_b = 1024 * 100, -- 100KB
				},
			},
			grep = {
				rg_glob = true, -- enable glob parsing
				glob_flag = "--iglob", -- case insensitive globs
				glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
			},
		})

		require("fzf-lua").register_ui_select()
	end,
	keys = {
		{ "<leader><space>", ":FzfLua global<CR>", { desc = "Smart Find" } },
		{ "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files" } },
		{ "<leader>fF", ":FzfLua git_files<CR>", { desc = "Find Files" } },
		{ "<leader>fb", ":FzfLua buffers<CR>", { desc = "Find Buffers" } },
		{ "<leader>fr", ":FzfLua oldfiles<CR>", { desc = "Recent Files" } },
		{ "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Live Grep" } },
		{ "<leader>fw", ":FzfLua grep_cWORD<CR>", { desc = "Grep WORD under cursor" } },
		{ "<leader>fW", ":FzfLua grep_cWORD<CR>", { desc = "Grep WORD under cursor" } },
	},
}
