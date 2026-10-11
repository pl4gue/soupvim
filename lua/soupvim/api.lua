local api = vim.api
local uv = vim.uv or vim.loop
local fn = vim.fn

local M = {
	OS_NAME = fn.has("wsl") == 1 and "WSL" or uv.os_uname().sysname,
	AUGROUP = api.nvim_create_augroup("soupvim_group", { clear = true }),
	PATH = uv.fs_realpath(fn.stdpath("config") .. "/lua/soupvim"),
	RELATIVE_ROOT = uv.fs_realpath(fn.stdpath("config") .. "/lua"),
	MODULE_CACHE = {},
	OBSIDIAN_VAULT_LOCATION = vim.fn.fnamemodify("~/docs/soupsidian", ":p"),
}

M.is_cwd_inside = function(target_folder)
	local target = vim.fn.fnamemodify(target_folder, ":p"):gsub("[/\\]$", "")
	---@diagnostic disable-next-line: param-type-mismatch
	local cwd = vim.fn.fnamemodify(vim.uv.cwd(), ":p"):gsub("[/\\]$", "")

	-- True if exact match or if CWD is a deeper subdirectory
	return cwd == target or string.sub(cwd, 1, string.len(target) + 1) == target .. "/"
end

local function get_relative_path()
	local source = debug.getinfo(3, "S").source
	local cached = soupvim.MODULE_CACHE[source]
	if cached then
		return cached
	end

	local path_separator = soupvim.OS_NAME == "Windows_NT" and "\\" or "/"
	local opposite_separator = soupvim.OS_NAME == "Windows_NT" and "/" or "\\"

	local path = source:sub(2):gsub(opposite_separator, path_separator)
	local directory = path:match("(.*" .. path_separator .. ")")

	local relative = directory:gsub(soupvim.RELATIVE_ROOT .. path_separator, ""):gsub(path_separator, "."):sub(1, -2)

	soupvim.MODULE_CACHE[source] = relative
	return relative
end

--- Requires lua files relative to soupvim.
---
---@param path string Path to module
---@param relative? boolean (Defaults to true) Decides whether to require relative to current file path or not.
--- If true:
--- - ```lua soupvim/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.example')```
--- - ```lua soupvim/module/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.<module>.example')```
--- - ```lua soupvim/module/directory/*.lua
---    soupvim.require('example', true) -- is the same as calling require('soupvim.<module>.<directory>.example')```
--- If false:
--- - ```lua soupvim/**/*.lua
---    soupvim.require('example')        -- is the same as calling require('soupvim.example')
---    soupvim.require('module.example') -- is the same as calling require('soupvim.module.example') ```
---@return any # everything require() returns
function M.require(path, relative)
	relative = relative == nil and true or relative
	if path:sub(1, 1) == "." then
		path = path:sub(2)
	end

	if relative then
		return require(get_relative_path() .. "." .. path)
	end

	return require("soupvim." .. path)
end

---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
function M:create_autocmd(event, opts)
	if not opts then
		return
	end
	if opts.callback and type(opts.callback) ~= "function" then
		return
	end

	return api.nvim_create_autocmd(
		event,
		vim.tbl_deep_extend("keep", opts, {
			group = self.AUGROUP,
		})
	)
end

local function get_fold(lnum)
	if fn.foldlevel(lnum) <= fn.foldlevel(lnum - 1) then
		return " "
	end
	return "%C"
end

M.get_statuscol = function()
	return "" .. get_fold(vim.v.lnum) .. "%s%l "
end

---@param callback string|fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
function M:lsp_on_attach(callback)
	self:create_autocmd("LspAttach", {
		desc = "Soupvim LSP attach",
		callback = callback,
	})
end

function M.setup()
	-- vim.opt.rtp:append(soupvim.PATH)
	require("soupvim.core")

	-- ZPack
	vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })
	require("zpack").setup({
		defaults = { confirm = false },
		spec = { import = "soupvim.plugins" },
	})
end

return M
