--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                          Keymaps                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- :noh for searches
vim.keymap.set('n', '<Leader>hh', ':noh<CR>')

-- open Lexplore 15 columns wide
vim.keymap.set('n', '<Leader>e', ':silent Lex<CR>')

-- re-source config
vim.keymap.set('n', '<Leader>so', ':source<CR>')

-- (Visual mode) Shift + K/J moves blocks of lines
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Better behavior with Shift J
-- cursor wont go to the end of the line whenever you append
vim.keymap.set('n', 'J', "mzJ`z")

-- Default behavior if used with <Leader>
vim.keymap.set('n', '<Leader>J', "J")

-- Non-disorienting jumping to the middle of a document
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Good paste that doesnt forget shit
vim.keymap.set('x', '<leader>p', '\"_dP')
