
return {

  -- Adds git and the hub to nvim
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- If I ever need to merge then there's this one
  -- 'sindrets/diffview.nvim',

  -- If I ever want to copy a commit url or smth
  --'f-person/git-blame',

  {
    -- Adds cools signs in the sign column,
    -- also has a inline blame virtual text.

    'lewis6991/gitsigns.nvim',
    config = function()
      require 'soupvim.plugins.config.gitsigns'
    end
  },
}
