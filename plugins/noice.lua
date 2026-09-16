return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        cmdline = { view = "cmdline", },
        notify = { view = "notify", },
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            signature = {
                enabled = false,
                auto_open = {
                    enabled = false
                }
            },
            hover = { silent = true },
        },
        -- you can enable a preset for easier configuration
        presets = { long_message_to_split = true, },
        health = { checker = false }
    },
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    dependencies = { "MunifTanjim/nui.nvim", }
}
