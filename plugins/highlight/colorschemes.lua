--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                       Colorscheme                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local loaded = false

-- helper function
local function setup_colorschemes(colorschemes, default)
	for i, color in ipairs(colorschemes) do
		colorschemes[i].lazy = (color.name ~= default)
		colorschemes[i].priority = 1000

		if colorschemes[i].name ~= default then
			colorschemes[i].cmd = { "Telescope colorscheme" }
		end

		if colorschemes[i].config == nil then
			colorschemes[i].config = function()
				vim.cmd.colorscheme(default)
			end
		end
	end

	return colorschemes
end

-- list of colorschemes to have installed
local colorschemes = {
	{ "Everblush/nvim", name = "everblush" },
	{ "frenzyexists/aquarium-vim", name = "aquarium" },
	{ "morhetz/gruvbox", name = "gruvbox" },
	{ "decaycs/decay.nvim", name = "decay" },
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{ "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
	{ "Sly-Harvey/radium.nvim", name = "radium" },
	{ "sam4llis/nvim-tundra", name = "tundra" },
	{ "ribru17/bamboo.nvim", name = "bamboo" },
	{ "nyngwang/nvimgelion", name = "nvimgelion" },
	{ "kvrohit/substrata.nvim", name = "substrata" },
	{ "dgox16/oldworld.nvim", name = "oldworld" },
	{ "Yazeed1s/minimal.nvim", name = "minimal" },
	{ "Yazeed1s/oh-lucy.nvim", name = "oh-lucy" },
	{ "andreasvc/vim-256noir", name = "256noir" },
	{ "wadackel/vim-dogrun", name = "dogrun" },
	{ "jacoborus/tender.vim", name = "tender" },
	{ "zenbones-theme/zenbones.nvim", name = "zenbones", dependencies = "rktjmp/lush.nvim" },
	{ "nikolvs/vim-sunbather", name = "sunbather" },
	{ "andreypopp/vim-colors-plain", name = "plain" },
	{ "ntk148v/komau.vim", name = "komau" },
	{ "cocopon/iceberg.vim", name = "iceberg" },
	{ "rakr/vim-two-firewatch", name = "firewatch" },
	{ "bluz71/vim-moonfly-colors", name = "moonfly" },
}

-- Loads
vim.api.nvim_create_user_command("Telescheme", function()
	if not loaded then
		for _, color in ipairs(colorschemes) do
			vim.cmd("Lazy load " .. color.name)
		end
	end

	loaded = true

	require("telescope.builtin").colorscheme({ ignore_builtins = true })
end, {})

-- default colorscheme
local colorscheme = "everblush"

return setup_colorschemes(colorschemes, colorscheme)
