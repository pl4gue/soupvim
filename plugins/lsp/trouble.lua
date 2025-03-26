--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        LSP Config                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

-- ─[ Trouble ]────────────────────────────────────────────────────────
--
-- Pretty list of diagnostics, telescope, quickfix, etc.

local trouble = require("trouble")
trouble.setup({
})

vim.keymap.set("n", "<Leader>tt", function()
	trouble.toggle("todo")
end, { desc = "[T]rouble [T]odo" })
