--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                       Nvim Options                       │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local o = vim.opt
local g = vim.g

-- Search
o.ignorecase = true
o.incsearch = true
o.smartcase = true
o.hlsearch = true

-- Indents, spaces
o.autoindent = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

-- UI
o.background = "dark"
o.number = true
o.relativenumber = true
o.signcolumn = "number"
o.list = false
o.fillchars:append({ eob = " ", fold = " ", foldsep = " ", foldopen = "", foldclose = "" }) ---@diagnostic disable-line: param-type-mismatch
o.confirm = true
o.pumheight = 10

-- Text
o.textwidth = 100
o.wrap = false
o.linebreak = true
o.breakindent = true

-- Folding
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.foldtext = "v:lua.foldText()"

_G.foldText = function()
	local line = vim.fn.getline(vim.v.foldstart)
	line = vim.fn.substitute(line, [[/\*\|\*/\|{{{\d\=]], "", "g")
	local lcount = vim.v.foldend - vim.v.foldstart

	return line .. " ⋯ " .. lcount
end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Clipboard (scheduling can increase startup time)
vim.schedule(function()
	o.clipboard = "unnamedplus"
end)

-- Mouse & Cursor
o.mouse = "a"
o.cursorline = true
o.cursorcolumn = false
o.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}
o.scrolloff = 10

-- Split
o.splitright = true
o.splitbelow = true

-- Undo
o.undofile = true

-- Completion
o.wildmenu = true
o.wildmode = "list:full"
o.complete = {
	opt = { "menu", "menuone", "noselect" },
}

-- NetRW
g.netrw_banner = false
g.netrw_liststyle = 3 -- Filetree
g.netrw_preview = 1 -- Vertical splits
g.netrw_alto = 0 -- Splits on the left
g.netrw_winsize = 15 -- Window size of NetRW
g.netrw_browse_split = 0
g.netrw_chgwin = -1
