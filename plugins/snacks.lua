return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        picker = { enabled = true },
    },


    keys = {
        { "<leader>ff", function() Snacks.picker.smart() end,           desc = "Smart Find Files" }, ---@diagnostic disable-line: undefined-global
        { "<leader>,",  function() Snacks.picker.buffers() end,         desc = "Buffers" }, ---@diagnostic disable-line: undefined-global
        { "<leader>fw", function() Snacks.picker.grep() end,            desc = "Grep" }, ---@diagnostic disable-line: undefined-global
        { "<leader>f:", function() Snacks.picker.command_history() end, desc = "Command History" }, ---@diagnostic disable-line: undefined-global
        { "<leader>e",  function() Snacks.explorer() end,               desc = "File Explorer" }, ---@diagnostic disable-line: undefined-global
        { "<leader>fg", function() Snacks.picker.git_files() end,       desc = "Find Git Files" }, ---@diagnostic disable-line: undefined-global
        { "<leader>fr", function() Snacks.picker.recent() end,          desc = "Recent" }, ---@diagnostic disable-line: undefined-global
    }
}
