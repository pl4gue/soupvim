return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local headers = soupvim.require("headers", true)

			dashboard.section.buttons.opts.spacing = 0

			local header = headers:setup_random(true)
			local header_padding = math.max(math.floor((32 - #header.val) / 2), 3)

			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("f", " " .. " Find file", ":FzfLua files<CR>"),
					dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
					dashboard.button("r", " " .. " Recent files", ":FzfLua oldfiles<CR>"),
					dashboard.button("g", " " .. " Live grep", ":FzfLua live_grep<CR>"),
					dashboard.button("c", " " .. " Config", ":FzfLua files cwd=" .. soupvim.soupvim_path .. "<CR>"),
					dashboard.button("q", " " .. " Quit", ":qa<CR>"),
				},
			}

			dashboard.config.layout = {
				{ type = "padding", val = header_padding },
				header,
				{ type = "padding", val = header_padding + 1 },
				buttons,
				{ type = "padding", val = 4 },
				dashboard.section.footer,
			}

			dashboard.opts.opts.noautocmd = true
			require("alpha").setup(dashboard.opts)
		end,
	},
}
