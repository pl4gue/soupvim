local api = vim.api
local M = {}

function M:load_globals()
	local v = vim.uv or vim.loop
	local os_name = v.os_uname().sysname
	local fn = vim.fn

	self.default_colorscheme = "catppuccin"
	self.augroup = api.nvim_create_augroup("soupvim_group", { clear = true })

	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.is_windows = os_name == "Windows_NT"
	self.is_wsl = fn.has("wsl") == 1

	self.path_separator = self.is_windows and "\\" or "/"
	self.opposite_separator = self.is_windows and "/" or "\\"

	self.cache_dir = vim.uv.fs_realpath(fn.stdpath("cache"))
	self.data_dir = string.format("%s/site/", vim.uv.fs_realpath(fn.stdpath("data")))

	self.soupvim_path =
		vim.uv.fs_realpath(fn.stdpath("config") .. self.path_separator .. "lua" .. self.path_separator .. "soupvim")
	self.config_files = {
		plugins = self.soupvim_path .. "/plugins",
		options = self.soupvim_path .. "/core/options.lua",
		keymaps = self.soupvim_path .. "/core/keymaps.lua",
		autocmds = self.soupvim_path .. "/core/autocmd.lua",
	}

	self.profiling = false
	self.profile_path = vim.uv.fs_realpath(vim.fn.stdpath("state")) .. "/soupvim-profile.log"

	self.relative_root = self.soupvim_path:gsub(self.path_separator .. "soupvim", "")
	self.module_cache = {}

	self.home = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
end

local function relative_path()
	local source = debug.getinfo(3, "S").source
	local cached = soupvim.module_cache[source]
	if cached then
		return cached
	end

	local path = source:sub(2):gsub(soupvim.opposite_separator, soupvim.path_separator)
	local directory = path:match("(.*" .. soupvim.path_separator .. ")")

	local relative =
		directory:gsub(soupvim.relative_root .. soupvim.path_separator, ""):gsub(soupvim.path_separator, "."):sub(1, -2)

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
	if path:sub(1, 1) == "." then
		path = path:sub(2)
	end

	if relative then
		return require(relative_path() .. "." .. path)
	end

	return require("soupvim." .. path)
end

---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
function M.create_autocmd(event, opts)
	if opts.callback and type(opts.callback) ~= "function" then
		return
	end

	return api.nvim_create_autocmd(
		event,
		vim.tbl_deep_extend("keep", opts, {
			group = soupvim.augroup,
		})
	)
end

local log_files = {
	lsp = "lsp.log",
	nvim = "nvim.log",
	pack = "nvim-pack.log",
}

local actions = {
	edit = function(args)
		local file = soupvim.config_files[args[1]]
		if not file then
			vim.notify("Unknown Soupvim file: " .. args[1], vim.log.levels.ERROR)
			return
		end

		vim.cmd("e " .. vim.fn.fnameescape(soupvim.config_files[args[1]]))
	end,

	reload = function()
		vim.cmd("so " .. soupvim.soupvim_path .. "/init.lua")
	end,

	health = function()
		vim.cmd("checkhealth soupvim")
	end,

	profile = function()
		if soupvim.profiling then
			vim.cmd("profile stop")
			soupvim.profiling = false
			vim.cmd("edit " .. soupvim.profile_path)
			return
		end

		vim.cmd("profile start " .. soupvim.profile_path)
		vim.cmd("profile func *")
		vim.cmd("profile file *")

		soupvim.profiling = true
		vim.notify("Profiling started")
	end,

	logs = function(args)
		local log = vim.fn.stdpath("log") .. log_files[args[1]]

		if vim.fn.filereadable(log) == 0 then
			vim.notify("Neovim log doesn't exist: " .. log, vim.log.levels.WARN)
			return
		end

		vim.cmd("edit " .. vim.fn.fnameescape(log))
	end,
}

function M.setup_user_command()
	vim.api.nvim_create_user_command("Soupvim", function(opts)
		local action = actions[opts.fargs[1]]
		if action then
			action(vim.list_slice(opts.fargs, 2))
		end
	end, {
		nargs = "+",
		complete = function(_, cmdline, _)
			local args = vim.split(cmdline, "%s+", { trimempty = true })
			if #args == 1 then
				return vim.tbl_keys(actions)
			end

			if args[2] == "edit" then
				return vim.tbl_keys(soupvim.config_files)
			end

			if args[2] == "log" then
				return vim.tbl_keys(log_files)
			end

			return {}
		end,
	})
end

function M.setup_plugins()
	vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })
	require("zpack").setup({
		defaults = { confirm = false },
		spec = { import = "soupvim.plugins" },
	})
end

---@param callback string|fun(args: vim.api.keyset.create_autocmd.callback_args): boolean?
function M.lsp_on_attach(callback)
	soupvim.create_autocmd("LspAttach", {
		desc = "Soupvim LSP attach",
		callback = callback,
	})
end

function M.pad_banner(banner, size)
	local missing = size - #banner

	if missing <= 0 then
		return banner
	end

	local before = math.floor(missing / 2)
	local after = missing - before

	for _ = 1, before do
		table.insert(banner, 1, "")
	end

	for _ = 1, after do
		table.insert(banner, "")
	end
end

M:load_globals()
return M
