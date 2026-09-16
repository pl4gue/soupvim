--[[
╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                         autocmds                         │
│                                                          │
╰──────────────────────────────────────────────────────────╯
]]

local a = vim.api
local fn = vim.fn

-- closes Lexplore automatically when entering a file
soupvim.create_autocmd("BufWinEnter", {
    callback = function()
        if fn.getbufvar(fn.winbufnr(fn.winnr()), "&filetype") ~= "netrw" then
            for bufn = 1, fn.bufnr("$") do
                if fn.bufexists(bufn) and fn.getbufvar(bufn, "&filetype") == "netrw" then
                    vim.cmd("silent! bwipeout" .. bufn)
                    return
                end
            end
        end
    end,
    pattern = "*",
})

-- Highlights Yanked text
soupvim.create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
    pattern = "*",
})

-- Saves the colorscheme whenever it changes
soupvim.create_autocmd("ColorScheme", {
    callback = function(args)
        vim.g.LAST_COLORSCHEME = args.match
    end,
})

-- Loads last used colorscheme
soupvim.create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("colorscheme " .. vim.g.LAST_COLORSCHEME or soupvim.default_colorscheme)
    end,
})
