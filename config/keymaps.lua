--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                          Keymaps                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "When on visual mode, K will move up blocks of lines." })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "When on visual mode, J will move down blocks of lines." })

map("n", "J", "mzJ`z", { desc = "When using J the cursor won't go to the end of the line." })

map("n", "<Leader>J", "J", { desc = "Default J behavior if used with <Leader>." })

map("n", "<C-d>", "<C-d>zz", { desc = "Non-disorienting jump dowm in the middle of a document." })
map("n", "<C-u>", "<C-u>zz", { desc = "Non-disorienting jump up in the middle of a document." })

map("n", "n", "nzzzv", { desc = "Non-disorienting jump to next search result." })
map("n", "N", "Nzzzv", { desc = "Non-disorienting jump to previous search result." })

map("x", "<Leader>p", '"_dP', { desc = "Good paste that doesnt forget shit." })

map({ "n", "x" }, "<Leader>y", '"+y', { desc = "y but on system clipboard." })
map({ "n", "x" }, "<Leader>Y", '"+Y', { desc = "Y but on system clipboard." })

-- Cycle through quickfix list items
map("n", "]q", "<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>", { silent = true })
map("n", "[q", "<Cmd>try | cprevious | catch | clast | catch | endtry<CR>", { silent = true })

map(
	"n",
	"<Leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace using the contents of the word under the cursor." }
)

-- Go to window with <Leader><window number>
for i = 1, 6 do
	local lhs = "<Leader>" .. i
	local rhs = i .. "<C-W>w"
	map("n", lhs, rhs, { desc = "Move to window " .. i })
end
