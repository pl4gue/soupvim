local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

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


    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('n', '<leader>th',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
            '[T]oggle Inlay [H]ints')
    end
end)

local no_trouble = require("no-trouble")
no_trouble.setup()

map("n", "[d", no_trouble.actions.prev, "Go to previous diagnostic in workspace (no-trouble)")
map("n", "]d", no_trouble.actions.next, "Go to next diagnostic in workspace (no-trouble)")

local servers = {
    -- clangd = {},
    -- bashls = {},
    -- pyright = {},
    -- gopls = {},

    lua_ls = {
        on_init = function(client)
            -- client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    path = { 'lua/?.lua', 'lua/?/init.lua' },
                },
                workspace = {
                    checkThirdParty = false,
                    -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                    --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                    library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                        '${3rd}/luv/library',
                        '${3rd}/busted/library',
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

require('mason').setup {}


local ensure_installed = vim.tbl_keys(servers or {})
-- You can add other tools here that you want Mason to install
-- vim.list_extend(ensure_installed, { })

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end
