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
o.background = 'dark'
o.number = true
o.relativenumber = true
o.termguicolors = true
o.showcmd = true
o.cmdheight = 0
o.scrolloff = 2
o.sidescrolloff = 2
o.laststatus = 3
o.signcolumn = 'number'
o.list = true
o.listchars:append({ tab = '»-' })
o.listchars:append({ trail = '.' })
o.listchars:append({ extends = '»' })
o.listchars:append({ precedes = '«' })
o.fillchars:append({ eob = ' ', fold = ' ', foldsep = ' ', foldopen = '', foldclose = '' })
o.confirm = true
o.pumheight = 10


-- Text
o.textwidth = 100
o.wrap = false
o.linebreak = true
o.breakindent = true

-- Folding
o.foldcolumn = '1'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- Clipboard
o.clipboard = 'unnamedplus'

-- Mouse
o.mouse = 'a'

-- Cursor
o.cursorline = true
o.cursorcolumn = false
o.guicursor = {
    'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
    'i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100',
    'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100',
}

-- Split
o.splitright = true
o.splitbelow = true

-- Undo
o.undofile = true

-- Completion
o.wildmenu = true
o.wildmode = 'list:full'
o.complete.opt = {'menu', 'menuone', 'noselect'}

-- NetRW
g.netrw_banner = false
g.netrw_liststyle = 3 -- Filetree
g.netrw_preview = 1 -- Vertical splits
g.netrw_alto = 0 -- Splits on the left
g.netrw_winsize = 15 -- Window size of NetRW
g.netrw_browse_split = 0
g.netrw_chgwin = -1
