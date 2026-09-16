return {
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        version = vim.version.range '1.*',
        dependencies = {
            'L3MON4D3/LuaSnip',
            version = vim.version.range '2.*',
        },
        config = function()
            require('blink.cmp').setup {
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

                    ['<Tab>'] = {
                        function(cmp)
                            return cmp.snippet_active() and cmp.accept() or cmp.select_and_accept()
                        end,
                        'snippet_forward',
                        'fallback'
                    },
                    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

                    ['<C-l>'] = { 'snippet_forward', 'fallback_to_mappings' },
                    ['<C-h>'] = { 'snippet_backward', 'fallback_to_mappings' },

                    ['Up'] = { 'select_prev', 'fallback' },
                    ['Down'] = { 'select_next', 'fallback' },

                    ['<M-k>'] = { 'select_prev', 'fallback_to_mappings' },
                    ['<M-j>'] = { 'select_next', 'fallback_to_mappings' },

                    ['<C-k>'] = { 'scroll_documentation_up', 'fallback_to_mappings' },
                    ['<C-j>'] = { 'scroll_documentation_down', 'fallback_to_mappings' },

                    ['<CR>'] = { 'accept', 'fallback' },

                    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback_to_mappings' },
                    ['<C-e>'] = { 'hide', 'fallback_to_mappings' },

                    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
                },

                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono',
                },

                cmdline = {
                    keymap = {
                        preset = 'inherit',
                        ['<CR>'] = { 'accept_and_enter', 'fallback' },
                    },

                    completion = {
                        menu = { auto_show = function(_) return vim.fn.getcmdtype() == ':' end },
                        list = {
                            selection = {
                                -- Preselects only if cmdline is bigger than 3 characters
                                -- Tabbing still works nicely with this setup
                                preselect = function() return #vim.fn.getcmdline():gsub("^%s*(.-)%s*$", "%1") > 3 end
                            }
                        },
                        ghost_text = { enabled = false },
                    }
                },

                completion = {
                    -- By default, you may press `<c-space>` to show the documentation.
                    -- Optionally, set `auto_show = true` to show the documentation after a delay.
                    documentation = { auto_show = true, auto_show_delay_ms = 500 },
                    list = { selection = { preselect = false, auto_insert = false } },
                    menu = { draw = {
                        align_to = 'cursor',
                        treesitter = { 'lsp' }
                    } },
                    ghost_text = { enabled = true, show_without_selection = true },
                },

                snippets = { preset = 'luasnip' },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
                -- which automatically downloads a prebuilt binary when enabled.
                --
                -- By default, we use the Lua implementation instead, but you may enable
                -- the rust implementation via `'prefer_rust_with_warning'`
                --
                -- See `:help blink-cmp-config-fuzzy` for more information
                fuzzy = { implementation = 'prefer_rust_with_warning' },

                -- Shows a signature help window while you type arguments for a function
                signature = { enabled = true, window = { show_documentation = true } },
            }
        end
    },
}
