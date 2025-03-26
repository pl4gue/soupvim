-- ┌          ┐
-- │ undotree │
-- └          ┘

local map = vim.keymap.set

return {
	"mbbill/undotree",
	config = function()
		map("n", "<Leader>u", function()
			vim.cmd.UndotreeToggle()
			vim.cmd.UndotreeFocus()
		end, { desc = "Toggles UndoTree" })
	end,
}
