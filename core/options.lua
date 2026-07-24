--[[
╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                         Options                          │
│                                                          │
╰──────────────────────────────────────────────────────────╯
]]

local o = vim.o
local opt = vim.opt
local g = vim.g

o.updatetime = 250 -- Decrease update time
o.timeoutlen = 300 -- Decrease mapped sequence wait time

soupvim.set_colorscheme(soupvim.coloscheme)

-- [ search ]
o.incsearch = true  -- Enables incremental search, showing where the matching results are while searching
o.hlsearch = true   -- Highlights mathing search results
o.ignorecase = true -- [ Case-insensitive searching UNLESS \C
o.smartcase = true  --   or one or more capital letters in the search term ]

-- [ cursor ]
o.mouse = 'a'       -- Enable mouse mode, can be useful for resizing splits for example!
o.cursorline = true -- Show which line your cursor is on
o.scrolloff = 10    -- Minimal number of screen lines to keep above and below the cursor.
opt.guicursor = {
    "n-v-c-sm:block-blinkon500-blinkoff500",
    "i-ci-ve:ver25-blinkon500-blinkoff500",
    "r-cr-o:hor20-blinkon500-blinkoff500",
    "t:block-blinkon500-blinkoff500-TermCursor"
}

-- [ clipboard ]
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- [ undofile ]
o.undofile = true -- Enable undo/redo changes even after closing and reopening a file

-- [ splits ]
o.splitright = true -- New vertical splits will be placed on the right
o.splitbelow = true -- New horizontal splits will be placed on the right

-- [ ui ]
o.termguicolors = true
o.background = "dark"   -- Enables dark background
vim.cmd.colorscheme = 'catpuccin' -- Default colorscheme
o.number = true         -- Make line numbers default
o.relativenumber = true -- Make relative line numbers default
o.signcolumn = 'number' -- Keep signcolumn on the line number column
o.showmode = false      -- Don't show the mode, since it's already in the status line
o.pumheight = 10

o.list = true
opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
opt.fillchars:append({ eob = " ", fold = " ", foldsep = " ", foldopen = "", foldclose = "" }) ---@diagnostic disable-line: param-type-mismatch

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- [ wrapping and indentation ]
o.autoindent = true
o.smartindent = true
o.expandtab = true    -- Expands tabs into spaces
o.tabstop = 4         -- 4 character wide tab
o.shiftwidth = 0      -- Shifting with '<' or '>' will use the same as tabstop

o.textwidth = 80      -- How long may a line be
o.wrap = false        -- No wrapping
o.linebreak = true    -- Auto line break when reaching 80 characters
o.breakindent = true  -- Enable break indent

-- [ folding ]
o.foldenable = true
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldtext = [[substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=', '', 'g') .. ' ⋯ ' .. (v:foldend - v:foldstart + 1)]]

-- TODO: put the following on treesitter's config
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"

-- [ netrw ]
g.netrw_banner = false
g.netrw_liststyle = 3 -- Filetree
g.netrw_preview = 1 -- Vertical splits
g.netrw_alto = 0 -- Splits on the left
g.netrw_winsize = 15 -- Window size of NetRW
g.netrw_browse_split = 0
g.netrw_chgwin = -1

local function get_fold(lnum)
	if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then return ' ' end
	return '%C'
end

_G.get_statuscol = function()
	return "" .. get_fold(vim.v.lnum) .. "%s%l "
end


vim.o.statuscolumn = "%!v:lua.get_statuscol()"
