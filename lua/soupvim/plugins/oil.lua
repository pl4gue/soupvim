return {
	"barrettruth/canola.nvim",
	main = "oil",
	cmd = "Oil",
	opts = {
		default_file_explorer = true,
		view_options = { show_hidden = true },
		keymaps = {
			["q"] = {
				callback = function()
					if vim.api.nvim_win_get_config(0).relative ~= "" then
						require("oil").close()
					end
				end,
			},
		},
	},
	keys = { "-", ":Oil --float <CR>", desc = "Open Oil", mode = "n" },
	init = function()
		-- Disables netrw if Oil is initing
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Autocmd that opens Oil as a replacement for Netrw
		soupvim.create_autocmd("BufEnter", {
			desc = string.format("[%s] replacement for Netrw", "oil"),
			pattern = "*",
			callback = function()
				local previous_buffer_name
				vim.schedule(function()
					local buffer_name = vim.api.nvim_buf_get_name(0)
					if vim.fn.isdirectory(buffer_name) == 0 then
						_, previous_buffer_name = pcall(vim.fn.expand, "#:p:h")
						return
					end

					-- Avoid reopening when exiting without selecting a file
					if previous_buffer_name == buffer_name then
						previous_buffer_name = nil
						return
					else
						previous_buffer_name = buffer_name
					end

					-- Ensure no buffers remain with the directory name
					vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })
					require("oil").open(vim.fn.expand("%:p:h"))
				end)
			end,
		})
	end,
}
