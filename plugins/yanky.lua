return {
    "gbprod/yanky.nvim",
    lazy = true,
    opts = {},
    keys = {
        { "p",     "<Plug>(YankyPutAfter)",      mode = { "n", "x" } },
        { "P",     "<Plug>(YankyPutBefore)",     mode = { "n", "x" } },
        { "gp",    "<Plug>(YankyGPutAfter)",     mode = { "n", "x" } },
        { "gP",    "<Plug>(YankyGPutBefore)",    mode = { "n", "x" } },

        { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = "n" },
        { "<c-n>", "<Plug>(YankyNextEntry)",     mode = "n" },
    },
}
