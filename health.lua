local M = {}

local function check_executable(name, required)
    required = required or false

	if vim.fn.executable(name) == 1 then
		vim.health.ok(name .. " is installed")
	elseif required then
		vim.health.error(name .. " is not installed")
	else
		vim.health.warn(name .. " is not installed")
	end
end

local function check_plugin(name)
	local ok, _ = pcall(require, "zpack")
	if ok then
		vim.health.ok(name .. " is loaded")
	else
		vim.health.error(name .. " could not be loaded")
	end
end

function M.check()
	-- vim.health.start("SoupVim")
	vim.health.ok("Soupvim started")

	local version = vim.version()

	if vim.version.cmp(version, { 0, 11, 0 }) >= 0 then
		vim.health.ok("Neovim version is supported: " .. tostring(version))
	else
		vim.health.error("Neovim >= 0.11.0 is required")
	end

	check_executable("git")

    check_plugin('zpack')
end

return M
