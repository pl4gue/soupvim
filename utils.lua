local api = vim.api
local M = {}

function M:load_globals()
    local v = vim.uv or vim.loop
    local os_name = v.os_uname().sysname
    local fn = vim.fn

    self.default_colorscheme = 'catppuccin'
    self.augroup = api.nvim_create_augroup("soupvim_group", { clear = true })
    self.is_mac = os_name == "Darwin"
    self.is_linux = os_name == "Linux"
    self.is_windows = os_name == "Windows_NT"
    self.is_wsl = fn.has("wsl") == 1
    self.vim_path = fn.stdpath("config")
    self.cache_dir = fn.stdpath("cache")
    self.data_dir = string.format("%s/site/", fn.stdpath("data"))

    self.path_separator = self.is_windows and "\\" or "/"
    self.opposite_separator = self.is_windows and "/" or "\\"

    self.soupvim_path = self.vim_path .. self.path_separator .. "lua" .. self.path_separator .. "soupvim"
    self.relative_root = self.soupvim_path:gsub(self.path_separator .. "soupvim", "")
    self.module_cache = {}

    self.home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
end

local function relative_path()
    local source = debug.getinfo(3, "S").source
    local cached = soupvim.module_cache[source]
    if cached then return cached end

    local path = source:sub(2):gsub(soupvim.opposite_separator, soupvim.path_separator)
    local directory = path:match("(.*" .. soupvim.path_separator .. ")")

    local relative = directory
        :gsub(soupvim.relative_root, "")
        :gsub(soupvim.path_separator, ".")
        :sub(1, -2)

    soupvim.module_cache[source] = relative
    return relative
end
--- Requires lua files relative to soupvim.
---
---@param path string Path to module
---@param relative? boolean (Defaults to false) Decides whether to require relative to current file path or not.
--- If `true`:
--- - ```lua soupvim/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.example')```
--- - ```lua soupvim/module/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.<module>.example')```
--- - ```lua soupvim/module/directory/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.<module>.<directory>.example')```
--- If `false`:
--- - ```lua soupvim/**/*.lua
---    soupvim.require('example')        -- is the same as calling require('soupvim.example')
---    soupvim.require('module.example') -- is the same as calling require('soupvim.module.example') ```
---@return unknown # everything require() returns
function M.require(path, relative)
    if path:sub(1, 1) == "." then path = path:sub(2) end

    if relative then return require(relative_path() .. "." .. path) end

    return require("soupvim." .. path)
end

---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
function M.create_autocmd(event, opts)
    if opts.callback and type(opts.callback) ~= "function" then
        return
    end

    return api.nvim_create_autocmd(event, vim.tbl_deep_extend('keep', opts, {
        group = soupvim.augroup
    }))
end

function M.setup_plugins()
    vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
    require('zpack').setup({
        performance = { vim_loader = true },
        defaults = { confirm = false },
        spec = { import = 'soupvim.plugins' },
    })
end

---@param callback string|fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
function M.lsp_on_attach(callback)
    soupvim.create_autocmd("LspAttach", {
        desc = "Soupvim LSP attach",
        callback = callback,
    })
end

M:load_globals()
return M
