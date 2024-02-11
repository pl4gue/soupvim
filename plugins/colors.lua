--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                       Colorscheme                        │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {

  -- Download your colorscheme with lazy.
  'nyoom-engineering/oxocarbon.nvim',

  -- Configure it inside this function.
  config = function()
    vim.opt.background = 'dark' -- set to dark or light
    vim.cmd('colorscheme oxocarbon')

    --[[
    Uncomment to make background transparent

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    ]]
  end
}
