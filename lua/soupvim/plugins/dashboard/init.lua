return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		cond = vim.fn.argv(0) == "" and not soupvim.is_cwd_inside(soupvim.OBSIDIAN_VAULT_LOCATION),
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local headers = soupvim.require("headers")

			dashboard.section.buttons.opts.spacing = 0

			-- local header = headers:setup_random(true)
            local header = headers:setup("gundam", true)
            -- local header = headers:setup("titlescreen", true)

			local header_padding = math.max(math.floor((vim.api.nvim_win_get_height(0) - #(header.val)) / 2), 3)

			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "SoupVim", opts = { hl = "SpecialComment", position = "center" } },
					-- { type = "padding", val = 1 },
					dashboard.button("f", " " .. " Find file", ":FzfLua files<CR>"),
					dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
					dashboard.button("r", " " .. " Recent files", ":FzfLua oldfiles<CR>"),
					dashboard.button("g", " " .. " Live grep", ":FzfLua live_grep<CR>"),
					dashboard.button("c", " " .. " Config", ":FzfLua files cwd=" .. soupvim.PATH .. "<CR>"),
					dashboard.button("q", " " .. " Quit", ":qa<CR>"),
				},
			}

			dashboard.config.layout = {
				{ type = "padding", val = header_padding },
				header,
				{ type = "padding", val = math.max(header_padding-6,2) },
				buttons,
				{ type = "padding", val = 2 },
				-- dashboard.section.footer,
			}

			dashboard.opts.opts.noautocmd = true
			require("alpha").setup(dashboard.opts)
		end,
	},
}
