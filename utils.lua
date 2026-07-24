local M = {}

function M:load_globals()
	local v = vim.uv or vim.loop
	local os_name = v.os_uname().sysname
	local fn = vim.fn

	self.coloscheme = 'catpuccin'  -- Default colorscheme if no plugins load
	self.augroup = vim.api.nvim_create_augroup("soupvim_group", { clear = true })
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.is_windows = os_name == "Windows_NT"
	self.is_wsl = fn.has("wsl") == 1
	self.vim_path = fn.stdpath("config")
	self.path_separator = self.is_windows and "\\" or "/"
	self.soupvim_path = self.vim_path .. self.path_separator .. "lua" .. self.path_separator .. "soupvim"
	self.cache_dir = fn.stdpath("cache")
	self.data_dir = string.format("%s/site/", fn.stdpath("data"))
	self.home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
end

local relative_path = function()
	local separator = soupvim.path_separator
	local opposite_separator = soupvim.is_windows and "/" or "\\"
	local str = debug
		.getinfo(3)                    -- gets info from the function that called the function that called this one
		.source                        -- gets the file absolute path
		:sub(2)                        -- removes @ that's on the beginning of the string
		:gsub(opposite_separator, separator) -- changes every wrong separator with the one from the system

	return str
		:match("(.*" .. separator .. ")")                                 -- gets path
		:gsub(soupvim.soupvim_path:gsub(separator .. "soupvim", ""), "") -- make path relative to soupvim
		:gsub(separator, ".")                                             -- replaces separator with "."
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
	relative = relative or false
	path = path:sub(1, 1) == "." and path:sub(2) or path
	return require((relative and relative_path() or "soupvim") .. (path and "." .. path or ""))
end

---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
function M.create_autocmd(event, opts)
	if opts.callback and type(opts.callback) ~= "function" then
		return
	end

	return vim.api.nvim_create_autocmd(event, vim.tbl_deep_extend('keep', opts, {
		group = soupvim.augroup
	}))
end

function M.setup_plugins()
	vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
	require('zpack').setup({ spec = { import = 'soupvim.plugins' } })
end

---@param callback string|fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
function M.lsp_on_attach(callback)
	soupvim.create_autocmd("LspAttach", {
		desc = "Soupvim LSP attach",
		callback = callback,
	})
end

function M.set_colorscheme(colorscheme)
	if soupvim.coloscheme == colorscheme then return end
	vim.cmd('colorscheme ' .. colorscheme)
	soupvim.coloscheme = colorscheme
end

M:load_globals()
return M
