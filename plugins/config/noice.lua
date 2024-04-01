--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Noice Nvim                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
  cmdline = {
    view = "cmdline_popup",
    opts = {
      position = {
       row = "30%",
       col = "50%",
      }
    }
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },

  },
}
