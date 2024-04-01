--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                  Linters and Formatters                  │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls.nvim" },

  config = function ()
    require('soupvim.plugins.config.none-ls')
  end,
}
