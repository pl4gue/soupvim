local if_nil = vim.F.if_nil

local default_terminal = {
  type = "terminal",
  command = nil,
  width = 69,
  height = 30,
  opts = {
    redraw = true,
    window_config = {},
  },
}

local default_header = {
  type = "text",
  val = {
    "⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣶⣤⣤⣤⣉⣉⣙⣛⡛⠻⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⠟⠛⠛⠛⠻⠿⠿⠿⠿⢿⣿⣷⣶⣶⣦⣤⣤⣉⣉⣉⠛⢻⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣦⣤⣤⣤⣤⣌⣉⣉⣉⣉⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢠⡿⠋⣽⠟⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢠⡿⢁⣼⠋⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠻⣧⠘⢿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠙⣷⡈⢻⣆⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣠⣿⣃⣼⣏⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⡏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢹⣿⣿",
    "⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀SoupVim⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿",
    "⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡶⠶⠶⠶⠶⠶⠶⢶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
    "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
  },
  opts = {
    position = "center",
    hl = "Type",
  },
}

local footer = {
  type = "text",
  val = "",
  opts = {
    position = "center",
    hl = "Number",
  },
}

local leader = "LDR"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 3,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    button("e", "  New file", "<cmd>ene <CR>"),
    button("LDR f f", "󰈞  Find file"),
    button("LDR f h", "󰊄  Recently opened files"),
    button("LDR f r", "  Frecency/MRU"),
    button("LDR f g", "󰈬  Find word"),
    button("LDR f m", "  Jump to bookmarks"),
    button("LDR s l", "  Open last session"),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  terminal = default_terminal,
  header = default_header,
  buttons = buttons,
  footer = footer,
}

local config = {
  layout = {
    { type = "padding", val = 5 },
    section.header,
    { type = "padding", val = 5 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5,

    -- More opts.
    --[[
        theme-specific setup,
        ran once before the first draw

        setup = function


        when true, use 'noautocmd' when setting 'alpha' buffer local options.
        this can help performance, but it will prevent the FileType autocmd from firing,
        which may break integration with other plguins.
        default: false (disabled)

        noautocmd = bool


        -table of default keymaps

        keymap = {
            -- nil | string | string[]: key combinations used to press an
            -- item.
            press = '<CR>',
            -- nil | string | string[]: key combination used to select an item to
            -- press later.
            press_queue = '<M-CR>'
        }
        ]]
  },
}

require("alpha").setup(config)
