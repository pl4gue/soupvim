local M = {}

-- State storage per project working directory:
-- M.state[cwd] = {
--   list = { { path = string, view = table }, ... },
--   last_index = number,
-- }
M.state = {}

local function get_cwd()
	return vim.fs.normalize(vim.fn.getcwd())
end

local function get_project_state()
	local cwd = get_cwd()
	if not M.state[cwd] then
		M.state[cwd] = {
			list = {},
			last_index = 1,
		}
	end
	return M.state[cwd]
end

--- Normalizes a file path
---@param path string
---@return string
local function normalize_path(path)
	if not path or path == "" then
		return ""
	end
	return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

--- Returns relative path for display
---@param path string
---@return string
local function display_path(path)
	local cwd = get_cwd()
	if path:sub(1, #cwd) == cwd then
		local rel = path:sub(#cwd + 2)
		if rel ~= "" then
			return rel
		end
	end
	return vim.fn.fnamemodify(path, ":~:.")
end

--- Check if a buffer is a regular file that can be saved
---@param bufnr number
---@return boolean
local function is_valid_buffer(bufnr)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return false
	end
	local buftype = vim.bo[bufnr].buftype
	local name = vim.api.nvim_buf_get_name(bufnr)
	return buftype == "" and name ~= ""
end

--- Find index of a path in the project list
---@param path string
---@return number|nil
function M.find_index(path)
	local state = get_project_state()
	local norm = normalize_path(path)
	for i, item in ipairs(state.list) do
		if item.path == norm then
			return i
		end
	end
	return nil
end

--- Saves the current window view/cursor position for the active buffer if it is in the list
function M.save_current_view()
	local bufnr = vim.api.nvim_get_current_buf()
	if not is_valid_buffer(bufnr) then
		return
	end
	local path = normalize_path(vim.api.nvim_buf_get_name(bufnr))
	local idx = M.find_index(path)
	if idx then
		local state = get_project_state()
		state.list[idx].view = vim.fn.winsaveview()
	end
end

--- Toggle current buffer in the saved list
function M.toggle()
	local bufnr = vim.api.nvim_get_current_buf()
	if not is_valid_buffer(bufnr) then
		vim.notify("Cannot save special or unnamed buffer", vim.log.levels.WARN, {
			title = "Buffers",
		})
		return
	end

	local path = normalize_path(vim.api.nvim_buf_get_name(bufnr))
	local state = get_project_state()
	local idx = M.find_index(path)

	if idx then
		table.remove(state.list, idx)
		if state.last_index > #state.list then
			state.last_index = math.max(1, #state.list)
		end
	else
		table.insert(state.list, {
			path = path,
			view = vim.fn.winsaveview(),
		})
		state.last_index = #state.list
	end
end

--- Jump directly to buffer by index in the list
---@param index number
function M.jump(index)
	local state = get_project_state()
	if #state.list == 0 then
		return
	end

	if index < 1 or index > #state.list then
		return
	end

	-- Save position of current buffer before leaving
	M.save_current_view()

	local item = state.list[index]
	state.last_index = index

	-- Switch to buffer or open file if unloaded
	local target_buf = vim.fn.bufnr(item.path)
	if target_buf ~= -1 and vim.api.nvim_buf_is_loaded(target_buf) then
		vim.api.nvim_set_current_buf(target_buf)
	else
		vim.cmd.edit(vim.fn.fnameescape(item.path))
	end

	-- Restore exact cursor position and view where user was before leaving
	if item.view then
		pcall(vim.fn.winrestview, item.view)
	end
end

--- Navigate forward in the saved buffer list
function M.next()
	local state = get_project_state()
	if #state.list == 0 then
		return
	end

	local current_path = normalize_path(vim.api.nvim_buf_get_name(0))
	local curr_idx = M.find_index(current_path)

	local next_idx
	if curr_idx then
		next_idx = (curr_idx % #state.list) + 1
	else
		next_idx = (state.last_index % #state.list) + 1
	end

	M.jump(next_idx)
end

--- Navigate backward in the saved buffer list
function M.prev()
	local state = get_project_state()
	if #state.list == 0 then
		return
	end

	local current_path = normalize_path(vim.api.nvim_buf_get_name(0))
	local curr_idx = M.find_index(current_path)

	local prev_idx
	if curr_idx then
		prev_idx = ((curr_idx - 2) % #state.list) + 1
	else
		prev_idx = state.last_index or #state.list
	end

	M.jump(prev_idx)
end

--- Clear the list for current project
function M.clear()
	local state = get_project_state()
	state.list = {}
	state.last_index = 1
	vim.notify("Cleared buffer list", vim.log.levels.INFO, {
		title = "Buffers",
	})
end

--- Returns the list of saved buffers for current project
function M.get_list()
	return get_project_state().list
end

--- Interactive floating menu to view, jump, reorder, or delete saved buffers
function M.menu()
	local state = get_project_state()
	local list = state.list

	if #list == 0 then
		return
	end

	local current_path = normalize_path(vim.api.nvim_buf_get_name(0))

	-- Calculate window dimensions
	local width = 64
	local max_path_len = width - 14
	local height = math.min(#list + 4, 20)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false

	local lines = {}
	local active_line = 1

	for i, item in ipairs(list) do
		local is_curr = item.path == current_path
		local indicator = is_curr and "●" or "○"
		local dpath = display_path(item.path)
		if #dpath > max_path_len then
			dpath = "…" .. dpath:sub(#dpath - max_path_len + 2)
		end

		local line = string.format(" %2d. %s  %s", i, indicator, dpath)
		table.insert(lines, line)

		if is_curr then
			active_line = i
		end
	end

	table.insert(lines, "")
	table.insert(lines, " [CR] jump | [d] del | [J/K] move | [c] clear | [q] close")

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	local ui = vim.api.nvim_list_uis()[1]
	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Saved Buffers ",
		title_pos = "center",
	})

	vim.api.nvim_win_set_cursor(win, { active_line, 0 })

	-- Menu helper to refresh content
	local function refresh_menu()
		if not vim.api.nvim_win_is_valid(win) or not vim.api.nvim_buf_is_valid(buf) then
			return
		end
		if #list == 0 then
			vim.api.nvim_win_close(win, true)
			return
		end

		local new_lines = {}
		local cur = vim.api.nvim_win_get_cursor(win)[1]

		for i, item in ipairs(list) do
			local is_curr = item.path == current_path
			local indicator = is_curr and "●" or "○"
			local dpath = display_path(item.path)
			if #dpath > max_path_len then
				dpath = "…" .. dpath:sub(#dpath - max_path_len + 2)
			end
			table.insert(new_lines, string.format(" %2d. %s  %s", i, indicator, dpath))
		end
		table.insert(new_lines, "")
		table.insert(new_lines, " [CR] jump | [d] del | [J/K] move | [c] clear | [q] close")

		vim.bo[buf].modifiable = true
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
		vim.bo[buf].modifiable = false

		local new_cursor = math.min(cur, #list)
		vim.api.nvim_win_set_cursor(win, { math.max(1, new_cursor), 0 })
	end

	-- Keybindings for floating menu
	local function map_menu(lhs, fn)
		vim.keymap.set("n", lhs, fn, { buffer = buf, nowait = true, silent = true })
	end

	-- Jump on <CR>
	map_menu("<CR>", function()
		local cur_row = vim.api.nvim_win_get_cursor(win)[1]
		if cur_row <= #list then
			vim.api.nvim_win_close(win, true)
			M.jump(cur_row)
		end
	end)

	-- Delete item on d / x / dd
	local delete_item = function()
		local cur_row = vim.api.nvim_win_get_cursor(win)[1]
		if cur_row <= #list then
			table.remove(list, cur_row)
			refresh_menu()
		end
	end
	map_menu("d", delete_item)
	map_menu("x", delete_item)
	map_menu("dd", delete_item)

	-- Move item down on J / <C-j>
	local move_down = function()
		local cur_row = vim.api.nvim_win_get_cursor(win)[1]
		if cur_row < #list then
			local item = table.remove(list, cur_row)
			table.insert(list, cur_row + 1, item)
			refresh_menu()
			vim.api.nvim_win_set_cursor(win, { cur_row + 1, 0 })
		end
	end
	map_menu("J", move_down)
	map_menu("<C-j>", move_down)

	-- Move item up on K / <C-k>
	local move_up = function()
		local cur_row = vim.api.nvim_win_get_cursor(win)[1]
		if cur_row > 1 and cur_row <= #list then
			local item = table.remove(list, cur_row)
			table.insert(list, cur_row - 1, item)
			refresh_menu()
			vim.api.nvim_win_set_cursor(win, { cur_row - 1, 0 })
		end
	end
	map_menu("K", move_up)
	map_menu("<C-k>", move_up)

	-- Clear all
	map_menu("c", function()
		M.clear()
		vim.api.nvim_win_close(win, true)
	end)

	-- Direct jump 1-9
	for i = 1, math.min(9, #list) do
		map_menu(tostring(i), function()
			vim.api.nvim_win_close(win, true)
			M.jump(i)
		end)
	end

	-- Close menu
	map_menu("q", function()
		vim.api.nvim_win_close(win, true)
	end)
	map_menu("<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end)
end

--- Optional fzf-lua integration
function M.fzf()
	local ok, fzf = pcall(require, "fzf-lua")
	if not ok then
		M.menu()
		return
	end

	local list = get_project_state().list
	if #list == 0 then
		return
	end

	local entries = {}
	for i, item in ipairs(list) do
		table.insert(entries, string.format("%d: %s", i, display_path(item.path)))
	end

	fzf.fzf_exec(entries, {
		prompt = "Saved Buffers> ",
		actions = {
			["default"] = function(selected)
				if not selected or #selected == 0 then
					return
				end
				local idx = tonumber(selected[1]:match("^(%d+):"))
				if idx then
					M.jump(idx)
				end
			end,
			["ctrl-x"] = function(selected)
				if not selected or #selected == 0 then
					return
				end
				local idx = tonumber(selected[1]:match("^(%d+):"))
				if idx then
					table.remove(list, idx)
				end
			end,
		},
	})
end

function M.serialize_state()
	local st = get_project_state()
	if not st then
		return
	end
	local serial = {
		list = st.list,
		last_index = st.last_index,
	}
	-- We need a stable, session-scoped place to store this.
	-- If mini.sessions exposes a per-session store, the hook will place serial there.
	-- Here we expose a module-level method to fetch the serial for the current session.
	vim.g.BUFFER_SERIAL = serial
end

-- Hydrate from the session data
function M.hydrate_state()
	local s = vim.g.BUFFER_SERIAL
	if s and s.list then
		local key = vim.fs.normalize(vim.fn.getcwd())
		M.state[key] = { list = s.list, last_index = s.last_index or 1 }
	end
end

-- Track buffer view whenever cursor leaves a buffer/window
local augroup = vim.api.nvim_create_augroup("SoupvimBufferList", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	group = augroup,
	callback = function()
		M.save_current_view()
	end,
})

-- User commands
vim.api.nvim_create_user_command("BufferToggle", M.toggle, { desc = "Toggle current buffer in saved list" })
vim.api.nvim_create_user_command("BufferNext", M.next, { desc = "Jump to next saved buffer" })
vim.api.nvim_create_user_command("BufferPrev", M.prev, { desc = "Jump to previous saved buffer" })
vim.api.nvim_create_user_command("BufferList", M.menu, { desc = "Open saved buffers menu" })
vim.api.nvim_create_user_command("BufferClear", M.clear, { desc = "Clear saved buffers" })
vim.api.nvim_create_user_command("BufferFzf", M.fzf, { desc = "Open saved buffers in fzf-lua" })

-- Keymaps
local map = vim.keymap.set

-- Requested primary cycling keys:
map("n", "<C-'>", M.next, { desc = "Next saved buffer" })
map("n", "<C-S-'>", M.prev, { desc = "Previous saved buffer" })
map("n", '<C-">', M.prev, { desc = "Previous saved buffer (terminal Shift+')" })

-- Save/toggle current buffer
map("n", "<C-s>", M.toggle, { desc = "Toggle current buffer in saved list" })

-- Leader keymaps for easy access
map("n", "<Leader>h", M.menu, { desc = "List / manage saved buffers" })
map("n", "<Leader>bf", M.fzf, { desc = "Find saved buffer (fzf)" })
