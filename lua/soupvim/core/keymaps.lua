--[[
╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                          Keymaps                         │
│                                                          │
╰──────────────────────────────────────────────────────────╯
]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local maps = {

	{
		"Leader>p",
		'"_dP',
		desc = "Good paste that doesnt forget shit.",
		mode = "x",
	},

	{
		"<Leader>y",
		'"+y',
		desc = "y but on system clipboard.",
		mode = { "n", "x" },
	},
	{
		"<Leader>Y",
		'"+Y',
		desc = "Y but on system clipboard.",
		mode = { "n", "x" },
	},

	-- Cycle through quickfix list items

	{
		"<Leader>s",
		[["hy:%s/<C-r>h//<left>]],
		desc = "Replace using the contents of the selected text.",
		mode = "v",
	},

	{
		"K",
		":m '<-2<CR>gv=gv",
		desc = "When on visual mode, K will move up blocks of lines.",
		mode = "v",
	},
	{
		"J",
		":m '>+1<CR>gv=gv",
		desc = "When on visual mode, J will move down blocks of lines.",
		mode = "v",
	},

	{ "J", "mzJ`z", desc = "When using J the cursor won't go to the end of the line." },

	{ "<Leader>J", "J", desc = "Default J behavior if used with <Leader>." },

	{ "<C-d>", "<C-d>zz", desc = "Non-disorienting jump dowm in the middle of a document." },
	{ "<C-u>", "<C-u>zz", desc = "Non-disorienting jump up in the middle of a document." },
	{ "n", "nzzzv", desc = "Non-disorienting jump to next search result." },
	{ "N", "Nzzzv", desc = "Non-disorienting jump to previous search result." },

	{ "<C-h>", "<C-w><C-h>", desc = "Move focus to the left window" },
	{ "<C-l>", "<C-w><C-l>", desc = "Move focus to the right window" },
	{ "<C-j>", "<C-w><C-j>", desc = "Move focus to the lower window" },
	{ "<C-k>", "<C-w><C-k>", desc = "Move focus to the upper window" },
	{
		"<C-w>",
		"<C-\\><C-n><C-w>h",
		silent = true,
		mode = "t",
	},

	{
		"<Leader>s",
		[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
		desc = "Replace using the contents of the word under the cursor.",
	},

	{ "<leader>u", ":Undotree<CR>", desc = "Opens undotree" },

	{ "[q", "<Cmd>try | cprevious | catch | clast | catch | endtry<CR>", silent = true },
	{ "]q", "<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>", silent = true },
}

-- Go to window with <Leader><window number>
for i = 1, 6 do
	local lhs = "<Leader>" .. i
	local rhs = i .. "<C-W>w"
	table.insert(maps, { lhs, rhs, desc = "Move to window " .. i })
end

for _, map in ipairs(maps) do
	local lhs, rhs = map[1], map[2]
	local opts = vim.tbl_extend("force", {}, map)
	opts[1], opts[2], opts.mode = nil, nil, nil

	vim.keymap.set(map.mode or "n", lhs, rhs, opts)
end
