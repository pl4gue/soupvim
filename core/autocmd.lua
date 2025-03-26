--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                       AutoCommands                       │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local a = vim.api
local fn = vim.fn
local autocmd = a.nvim_create_autocmd

-- closes Lexplore automatically when entering a file
autocmd("BufWinEnter", {
	callback = function()
		if fn.getbufvar(fn.winbufnr(fn.winnr()), "&filetype") ~= "netrw" then
			for bufn = 1, fn.bufnr("$") do
				if fn.bufexists(bufn) and fn.getbufvar(bufn, "&filetype") == "netrw" then
					vim.cmd("silent! bwipeout" .. bufn)
					return
				end
			end
		end
	end,
	pattern = "*",
})

-- Highlights Yanked text
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
	pattern = "*",
})
