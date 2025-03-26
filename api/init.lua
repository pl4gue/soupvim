---@class soupvim: soupvim.api
---@field global soupvim.global

---@class soupvim.api
---@field autocmds soupvim.api.autocmds
---@field lsp soupvim.api.lsp
local M = {}

local relative_path = function()
	local separator = soupvim.global.path_separator
	local opposite_separator = soupvim.global.is_windows and "/" or "\\"
	local str = debug
		.getinfo(3) -- gets info from the function that called the function that called this one
		.source -- gets the file absolute path
		:sub(2) -- removes @ that's on the beginning of the string
		:gsub(opposite_separator, separator) -- changes every wrong separator with the one from the system

	return str
		:match("(.*" .. separator .. ")") -- gets path
		:gsub(soupvim.global.soupvim_path:gsub(separator .. "soupvim", ""), "") -- make path relative to soupvim
		:gsub(separator, ".") -- replaces separator with "."
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

--- Sets soupvim.api metatable into another table
---@param tbl table
local function set_metatable(tbl)
	return setmetatable(tbl, {
		__index = function(t, k)
			t[k] = require("soupvim.api." .. k)
			return t[k]
		end,
	})
end

set_metatable(M)

---@param global soupvim.global
---@return soupvim
function M.setup_api(global)
	---@type soupvim
	local soupvim = vim.tbl_deep_extend("force", { global = global }, M)

	set_metatable(soupvim)

	return soupvim
end

return M
