return {
    {
        "nyoom-engineering/oxocarbon.nvim", lazy = true,
    },
    {
        'Everblush/nvim', name = 'everblush', lazy = true,
    },
    {
        "AvengeMedia/base46",
        -- lazy = true,
        config = function()
            soupvim.set_colorscheme('base46-rxyhn')
        end
    }
}
