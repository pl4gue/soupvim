--  ╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
--  │                                                          │
--  │                        Telescope                         │
--  │                                                          │
--  ╰──────────────────────────────────────────────────────────╯

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',                                  -- or, branch = '0.1.x',

  dependencies = {
    'nvim-lua/plenary.nvim',

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end
    }
  },

  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    -- Key Bindings

    vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<Leader>fc', builtin.colorscheme, {})

    vim.keymap.set('n', '<Leader>fd', builtin.diagnostics, {})

    -- Telescope Setup

    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<C-q>"] = require("trouble.providers.telescope").smart_open_with_trouble },
          n = { ["<C-q>"] = require("trouble.providers.telescope").smart_open_with_trouble }
        }
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      },

      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case", the default is "smart_case"
        }
      }
    })

    -- telescope.load_extension('fzf')       -- NOTE: Could try fzy later
  end
}
