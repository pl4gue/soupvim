return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
		harpoon:extend(harpoon_extensions.builtins.navigate_with_number())
		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-s>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-t>", function()
					harpoon.ui:select_menu_item({ tabedit = true })
				end, { buffer = cx.bufnr })
			end,
		})

		local function get_current_item(list)
			local current = vim.api.nvim_buf_get_name(0)

			return vim.iter(list.items):find(function(item)
				return string.find(current, item.value)
			end)
		end

		local function get_current_index(list)
			local current = vim.api.nvim_buf_get_name(0)
			for index, value in ipairs(list.items) do
				if string.find(current, value.value) then
					return index
				end
			end

			return nil
		end

		local function get_indices(list)
			local indices = {}

			for index in pairs(list.items) do
				if type(index) == "number" then
					table.insert(indices, index)
				end
			end

			table.sort(indices)

			return indices
		end

		vim.keymap.set("n", ";", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<C-s>", function()
			local list = harpoon:list()
			local current = get_current_item(list)
			if current then
				return list:remove(current)
			end

			list:add()
		end)

		vim.keymap.set("n", "<C-'>", function()
			local list = harpoon:list()
			local indices = get_indices(list)

			if #indices == 0 then
				return
			end

			local current = get_current_index(list)

			-- Find the position of the current sparse index
			local position = nil

			for i, index in ipairs(indices) do
				if index == current then
					position = i
					break
				end
			end

			local next_position

			if not position then
				next_position = 1
			else
				next_position = (position % #indices) + 1
			end

			list:select(indices[next_position])
		end)

		vim.keymap.set("n", "<C-S-'>", function()
			local list = harpoon:list()
			local indices = get_indices(list)

			if #indices == 0 then
				return
			end

			local current = get_current_index(list)

			local position = nil

			for i, index in ipairs(indices) do
				if index == current then
					position = i
					break
				end
			end

			local prev_position

			if not position then
				prev_position = #indices
			else
				prev_position = ((position - 2) % #indices) + 1
			end

			list:select(indices[prev_position])
		end)
	end,
}
