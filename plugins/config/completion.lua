--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                 Auto-Completion Config                   │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	-- Setup LuaSnip
	snippet = {
		expand = function(args) require("luasnip").lsp_expand(args.body) end,
	},

	mapping = cmp.mapping.preset.insert({

		-- Enter or Tab to complete
		-- If Enter is pressed but none item is selected then it's a new line.
		-- If Tab is pressed but none item is selected then it autocompletes.

		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),

		-- Ctrl+j or k will move the items, arrows up and down also works.
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		-- Ctrl+Space or Ctril+i to trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-i>"] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),

	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp_document_symbol" },
		{ name = "buffer" },
		{ name = "calc" },
		{
			name = "path",
			option = {
				trailing_slash = true,
				label_trailing_slash = true,
			},
		},
	},

	experimental = {
		-- Adds ghost text under cursor on suggestion.
		ghost_text = true,
	},
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
