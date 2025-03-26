---@class soupvim.api.lsp
local M = {}

local autocmd = require("soupvim.api.autocmds")

---@param callback fun(client:vim.lsp.Client,bufnr:integer)
function M.on_attach(callback)
	if type(callback) == "function" then
		autocmd.create("LspAttach", {
			desc = "Soupvim LSP attach",
			group = autocmd.soupvim_augroup,
			callback = function(event)
				local id = vim.tbl_get(event, "data", "client_id")
				local client = id and vim.lsp.get_client_by_id(id) or {}

				callback(client, event.buf)
			end,
		})
	end
end

function M.setup_capabilities()
	local lspconfig_defaults = require("lspconfig").util.default_config

	lspconfig_defaults.capabilities =
		vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
end

function M.default_setup(server_name)
	M.setup_server(server_name, {})
end

function M.setup_server(server_name, opts)
	if type(server_name) ~= "string" then
		return
	end

	if type(opts) ~= "table" then
		opts = {}
	end

	local lsp = require("lspconfig")[server_name]

	if lsp.manager then
		return
	end

	if not pcall(lsp.setup, opts) then
		local msg = "[soupvim-lsp] Failed to setup %s.\n Configure it using lspconfig to get the full error message."

		vim.notify(msg:format(server_name), vim.log.levels.WARN)
	end
end

return M
