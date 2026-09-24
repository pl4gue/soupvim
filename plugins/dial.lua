return {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.new({ pattern = "%Y-%m-%d", default_kind = "day" }),
                augend.date.new({ pattern = "%Y/%m/%d", default_kind = "day" }),
                augend.constant.alias.bool,
                augend.hexcolor.new({ case = "lower" }),
                augend.constant.new({ elements = { "[ ]", "[x]" }, word = false, cyclic = true }),
            },
        })
    end,
    keys = {
        {
            "<C-a>",
            function()
                require("dial.map").manipulate("increment", "normal")
            end,
            "n",
        },
        {
            "<C-x>",
            function()
                require("dial.map").manipulate("decrement", "normal")
            end,
            "n",
        },
        {
            "g<C-a>",
            function()
                require("dial.map").manipulate("increment", "gnormal")
            end,
            "n",
        },
        {
            "g<C-x>",
            function()
                require("dial.map").manipulate("decrement", "gnormal")
            end,
            "n",
        },
        {
            "<C-a>",
            function()
                require("dial.map").manipulate("increment", "visual")
            end,
            "x",
        },
        {
            "<C-x>",
            function()
                require("dial.map").manipulate("decrement", "visual")
            end,
            "x",
        },
        {
            "g<C-a>",
            function()
                require("dial.map").manipulate("increment", "gvisual")
            end,
            "x",
        },
        {
            "g<C-x>",
            function()
                require("dial.map").manipulate("decrement", "gvisual")
            end,
            "x",
        },
    },
}
