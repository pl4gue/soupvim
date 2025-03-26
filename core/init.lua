--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                      𝙽𝚎𝚘𝚟𝚒𝚖 𝙲𝚘𝚗𝚏𝚒𝚐                       │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯
-- Faster loading times
vim.loader.enable()

local global = require("soupvim.core.global")
require("soupvim.core.options")
require("soupvim.core.keymaps")
require("soupvim.core.autocmd")
require("soupvim.core.lazy")

_G.soupvim = require("soupvim.api").setup_api(global)
