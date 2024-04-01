--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                       Colorscheme                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local colorscheme = "everblush"

local colorschemes = {
  { "Mofiqul/adwaita.nvim",             name = "adwaita" },
  { "ribru17/bamboo.nvim",              name = "bamboo" },
  { "Everblush/nvim",                   name = "everblush" },
  { "rebelot/kanagawa.nvim",            name = "kanagawa" },
  { "kdheepak/monochrome.nvim",         name = "monochrome" },
  { "jesseleite/nvim-noirbuddy",        name = "noirbuddy", dependencies = { "tjdevries/colorbuddy.nvim" }, },
  { "nyngwang/nvimgelion",              name = "nvimgelion" },
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
  { "kvrohit/substrata.nvim",           name = "substrata" },
  { "mcchrish/zenbones.nvim",           name = "zenbones" },
}


for i, color in ipairs(colorschemes) do
  colorschemes[i].lazy = (color.name ~= colorscheme)
  colorschemes[i].priority = 1000

  if colorschemes[i].name ~= colorscheme then
    colorschemes[i].cmd = { "Telescope colorscheme" }
  end

  if colorschemes[i].config == nil then
    colorschemes[i].config = function ()
      vim.cmd.colorscheme(colorscheme)
    end
  end
end

return colorschemes
