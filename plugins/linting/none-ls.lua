return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        "nvimtools/none-ls.nvim",
        { "zeioth/none-ls-autoload.nvim", event = { "BufEnter" } },
    },

    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            on_attach = function(client, bufnr)
                local format_on_save = vim.api.nvim_create_augroup("LspFormatting", {})

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = format_on_save, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = format_on_save,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })

        require("mason-null-ls").setup({
            ensure_installed = {
                -- Lua
                "stylua",

                -- Python
                "black",

                -- Golang
                "gofumpt",
                "goimports_reviser",
                "golines",

                -- Web
                "prettierd",
            },
        })

        require("none-ls-autoload").setup({})
    end,
}
