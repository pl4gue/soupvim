return {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason-lspconfig.nvim' },
      { 'mason-org/mason.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' } ,

      { "pl4gue/no-trouble.nvim" },
    },

    config = function()
      soupvim.require('lspconfig', true)
    end
}
