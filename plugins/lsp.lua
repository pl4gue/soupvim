local servers = {
	-- clangd = {},
	-- bashls = {},
	-- pyright = {},
	-- gopls = {},

	rust_analyzer = {},

	lua_ls = {
		on_init = function(client)
			-- client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = { "lua/?.lua", "lua/?/init.lua" },
				},
				workspace = {
					checkThirdParty = false,
					-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
					--  See https://github.com/neovim/nvim-lspconfig/issues/3189
					library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					}),
				},
			})
		end,

		settings = {
			Lua = {
				hint = {
					enable = true,
					arrayIndex = "Disable",
					paramName = "Disable",
					setType = true,
				},
				diagnostics = { disable = { "missing-fields" } },
				-- format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
}

soupvim.lsp_on_attach(function(event)
	---@diagnostic disable-next-line: redefined-local
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
	end

	map("n", "<Leader>vd", vim.diagnostic.open_float, "[V]iew [D]iagnostic in float")
	map("n", "<Leader>gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions")
	map({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, "Signature help")
	map("n", "<Leader>f", vim.lsp.buf.format, "Format file")

	map("n", "[d", function()
		require("no-trouble").actions.prev()
	end, "Go to previous diagnostic in workspace (no-trouble)")
	map("n", "]d", function()
		require("no-trouble").actions.next()
	end, "Go to next diagnostic in workspace (no-trouble)")

	-- The following code creates a keymap to toggle inlay hints in your
	-- code, if the language server you are using supports them
	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client:supports_method("textDocument/inlayHint", event.buf) then
		map("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
		end, "[T]oggle Inlay [H]ints")
	end
end)

return {
	{ "mason-org/mason.nvim", event = "VeryLazy", opts = {} },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			auto_update = false,
			run_on_start = true,
			ensure_installed = vim.tbl_keys(servers or {}),
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = true,
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			for name, server in pairs(servers) do
				vim.lsp.config(name, server)
			end
		end,
	},

	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		version = vim.version.range("1.*"),
		dependencies = {
			"L3MON4D3/LuaSnip",
			version = vim.version.range("2.*"),
		},
		opts = {
			keymap = {
				-- preset = 'super-tab',
				--
				-- 'default' (recommended) for mappings similar to built-in completions
				--   <c-y> to accept ([y]es) the completion.
				--    This will auto-import if your LSP supports it.
				--    This will expand snippets if the LSP sent a snippet.
				-- 'super-tab' for tab to accept
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- For an understanding of why the 'default' preset is recommended,
				-- you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				--
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
				--
				-- See `:help blink-cmp-config-keymap` for defining your own keymap
				--
				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

				["<Tab>"] = {
					function(cmp)
						return cmp.snippet_active() and cmp.accept() or cmp.select_and_accept()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<C-l>"] = { "snippet_forward", "fallback_to_mappings" },
				["<C-h>"] = { "snippet_backward", "fallback_to_mappings" },

				["Up"] = { "select_prev", "fallback" },
				["Down"] = { "select_next", "fallback" },

				["<M-k>"] = { "select_prev", "fallback_to_mappings" },
				["<M-j>"] = { "select_next", "fallback_to_mappings" },

				["<C-k>"] = { "scroll_documentation_up", "fallback_to_mappings" },
				["<C-j>"] = { "scroll_documentation_down", "fallback_to_mappings" },

				["<CR>"] = { "accept", "fallback" },

				["<C-space>"] = { "show", "show_documentation", "hide_documentation", "fallback_to_mappings" },
				["<C-e>"] = { "hide", "fallback_to_mappings" },

				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			cmdline = {
				keymap = {
					preset = "inherit",
					["<CR>"] = { "accept_and_enter", "fallback" },
				},

				completion = {
					menu = {
						auto_show = function(_)
							return vim.fn.getcmdtype() == ":"
						end,
					},
					list = {
						selection = {
							-- Preselects only if cmdline is bigger than 3 characters
							-- Tabbing still works nicely with this setup
							preselect = function()
								return #vim.fn.getcmdline():gsub("^%s*(.-)%s*$", "%1") > 3
							end,
						},
					},
					ghost_text = { enabled = false },
				},
			},

			completion = {
				-- By default, you may press `<c-space>` to show the documentation.
				-- Optionally, set `auto_show = true` to show the documentation after a delay.
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				list = { selection = { preselect = false, auto_insert = false } },
				menu = {
					draw = {
						align_to = "cursor",
						treesitter = { "lsp" },
					},
				},
				ghost_text = { enabled = true, show_without_selection = true },
			},

			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
			-- which automatically downloads a prebuilt binary when enabled.
			--
			-- By default, we use the Lua implementation instead, but you may enable
			-- the rust implementation via `'prefer_rust_with_warning'`
			--
			-- See `:help blink-cmp-config-fuzzy` for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },

			-- Shows a signature help window while you type arguments for a function
			signature = {
				enabled = true,
				window = { show_documentation = true },
			},
		},
	},
	{ "pl4gue/no-trouble.nvim", event = "VeryLazy", opts = {} },
}
