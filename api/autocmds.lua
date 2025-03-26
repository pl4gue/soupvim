---@class soupvim.api.autocmds
---@field registered integer[]
---@field soupvim_augroup string|integer
local M = {
	registered = {},
	soupvim_augroup = vim.api.nvim_create_augroup("soupvim_group", { clear = true }),
}

--- creates and registers autocmds
---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
---@return integer
function M.create(event, opts)
	local cmd_id = vim.api.nvim_create_autocmd(event, opts)
	table.insert(M.registered, cmd_id)

	return cmd_id
end

return M
