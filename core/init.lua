--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                      𝙽𝚎𝚘𝚟𝚒𝚖 𝙲𝚘𝚗𝚏𝚒𝚐                       │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

-- Faster loading times
vim.loader.enable()

require('soupvim.core.options')
require('soupvim.core.keymaps')
require('soupvim.core.autocmd')
require('soupvim.core.lazy')


-- This is only here cuz if you don't have 
-- a nice terminal colorscheme your eyes will burn,
-- habamax is a nice built-in theme, so nvim will use it as default 
-- to prevent your eyes from falling from their sockets
--
-- Check plugins/colorscheme.lua and plugins/colors to use your own.

vim.cmd.colorscheme("habamax")
