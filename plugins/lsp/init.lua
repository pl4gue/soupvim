return {
    'mason-org/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        'neovim/nvim-lspconfig',
        { 'mason-org/mason.nvim', opts = {} },
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        "pl4gue/no-trouble.nvim",
    },

    config = function()
        soupvim.require('lspconfig', true)
    end
}
