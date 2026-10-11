return {
	"serhez/bento.nvim",
    event = "VeryLazy",
	config = function()
		require("bento").setup({})

		local api = require("bento.api")

		api.register_expand_key("<leader>b")
		api.register_last_buffer_key("l")
        api.register_collapse_key("<Esc>")            -- Collapse/close menu

        vim.keymap.set("n", "<C-'>", "<space>bl")

        api.register_prev_page_key("[")               -- Previous page (pagination)
        api.register_next_page_key("]")               -- Next page (pagination)

		api.register_action("open", {
			key = "<CR>",
			action = api.actions.open,
			hl = "DiagnosticVirtualTextHint",
		})
		api.register_action("delete", {
			key = "d",
			action = api.actions.delete,
			hl = "DiagnosticVirtualTextError",
		})
		api.register_action("vsplit", {
			key = "v",
			action = api.actions.vsplit,
			hl = "DiagnosticVirtualTextInfo",
		})
		api.register_action("split", {
			key = "s",
			action = api.actions.split,
			hl = "DiagnosticVirtualTextInfo",
		})
		api.register_action("lock", {
			key = "*",
			action = api.actions.lock,
			hl = "DiagnosticVirtualTextWarn",
		})

        -- Set default action
        api.set_default_action("open")
	end,
}
