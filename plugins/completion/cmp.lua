--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                 Auto-Completion Config                   │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

local cmp = require("cmp")

local luasnip = require("luasnip")

-- require("luasnip.loaders.from_vscode").lazy_load() if using friendly snippets
require("luasnip.loaders.from_lua").load({ paths = require("soupvim.core.global").soupvim_path .. "/snippets" })

cmp.setup({
	formatting = {
		fields = { "kind", "abbr", "menu" },

		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text" })(entry, vim.deepcopy(vim_item))
			local highlights_info = require("colorful-menu").cmp_highlights(entry)

			-- highlight_info is nil means we are missing the ts parser, it's
			-- better to fallback to use default `vim_item.abbr`. What this plugin
			-- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
			if highlights_info ~= nil then
				vim_item.abbr_hl_group = highlights_info.highlights
				vim_item.abbr = highlights_info.text
			end
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			vim_item.kind = " " .. (strings[1] or "") .. " "
			vim_item.menu = ""

			return vim_item
		end,
	},

	-- Setup LuaSnip
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		-- Enter will complete only if there's a selected entry
		["<Enter>"] = cmp.mapping.confirm({ select = false }),

		-- If on snippet trigger will expand it else will complete even if none is selected
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Goes back on luasnip
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- Ctrl+j or k will move the items, arrows up and down also works.
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

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
		{ name = "buffer" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp_document_symbol" },
		{ name = "calc" },
		{
			name = "path",
			option = {
				trailing_slash = true,
				label_trailing_slash = true,
			},
		},
	},

	-- Adds ghost text under cursor on suggestion.
	experimental = { ghost_text = true },
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
	sources = cmp.config.sources(
		{ { name = "path" } },
		{ { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
	),
})

cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
