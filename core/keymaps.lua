--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                          Keymaps                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- :noh for searches
map('n', '<Leader>hh', ':noh<CR>')

-- open Lexplore 15 columns wide
map('n', '<Leader>e', ':silent Lex<CR>')

-- re-source config
map('n', '<Leader>so', ':source<CR>')

-- (Visual mode) Shift + K/J moves blocks of lines
map('v', 'K', ":m '<-2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")

-- Better behavior with Shift J
-- cursor wont go to the end of the line whenever you append
map('n', 'J', "mzJ`z")

-- Default behavior if used with <Leader>
map('n', '<Leader>J', "J")

-- Non-disorienting jumping to the middle of a document
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Non-disorienting jumping to search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Good paste that doesnt forget shit
map('x', '<Leader>p', '\"_dP')

map({'n', 'x'}, '<Leader>y', '\"+y')
map({'n', 'x'}, '<Leader>Y', '\"+Y')

-- Replace using the contents of the word under the cursor.
map("n", "<Leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
