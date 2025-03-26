local v = vim.uv or vim.loop
local os_name = v.os_uname().sysname

---@class soupvim.global
local M = {}

-- put this in your main init.lua file ( before lazy setup )
-- vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

function M:load_variables()
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.is_windows = os_name == "Windows_NT"
	self.is_wsl = vim.fn.has("wsl") == 1
	self.vim_path = vim.fn.stdpath("config")
	self.path_separator = self.is_windows and "\\" or "/"
	self.soupvim_path = self.vim_path .. self.path_separator .. "lua" .. self.path_separator .. "soupvim"
	self.cache_dir = vim.fn.stdpath("cache")
	self.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
	self.home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
end

M:load_variables()

return M
