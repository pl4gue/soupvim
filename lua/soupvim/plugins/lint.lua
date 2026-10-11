return {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			-- markdown = { "markdownlint" }, -- Make sure to install `markdownlint` via mason / npm
		}

		-- Create autocommand which carries out the actual linting
		-- on the specified events.
		soupvim:create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				-- Only run the linter in buffers that you can modify in order to
				-- avoid superfluous noise, notably within the handy LSP pop-ups that
				-- describe the hovered symbol using Markdown.
				if vim.bo.modifiable then
					lint.try_lint()
				end
			end,
		})
	end,
}
