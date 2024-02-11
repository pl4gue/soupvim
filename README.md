<span align='center'>

╭───────────────────────°⌜ 赤い糸 ⌟°───────────────────────╮
│                                                          │
│                          SoupVim                         │
│                                                          │
│              ⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣶⣤⣤⣤⣉⣉⣙⣛⡛⠻⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⠟⠛⠛⠛⠻⠿⠿⠿⠿⢿⣿⣷⣶⣶⣦⣤⣤⣉⣉⣉⠛⢻⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣶⣶⣶⣶⣦⣤⣤⣤⣤⣌⣉⣉⣉⣉⠛⠛⢻⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⢠⡿⠋⣽⠟⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢠⡿⢁⣼⠋⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠻⣧⠘⢿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠙⣷⡈⢻⣆⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣠⣿⣃⣼⣏⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⡏⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⢹⣿⣿              │
│              ⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿              │
│              ⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡶⠶⠶⠶⠶⠶⠶⢶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│              ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿              │
│                                                          │
╰──────────────────────────────────────────────────────────╯

</span>

This is my souper 🥣 NeoVim config.

# 💻 Installation

To install SoupVim run the following command on your terminal.

```sh
cd ~/.config/nvim/lua/
git clone https://github.com/pl4g/soupvim.git
```

Then you want your `init.lua` file inside `~/.config/nvim/` to look like this:

```lua
--- init.lua
require('soupvim')
```

## 📋 Dependencies

SoupVim depend on some third-party software to run properly. Here's a list of the most important ones.

- [git](https://git-scm.com/) • For installation and project management.
- [fzf](https://github.com/junegunn/fzf) • For fuzzy finding.
- `gcc` or `clang` and `make`. • For [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim), check their README.
- [ripgrep](https://github.com/BurntSushi/ripgrep) • For some [telescope](https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#suggested-dependencies) functionality.
- [fd]() • *Optional* • For faster file finding on [telescope](https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#optional-dependencies).

# ✨ Features

- **Plugin Management** thanks to [lazy.nvim](https://github.com/folke/lazy.nvim).
- **Fuzzy Finding** with [telescope](https://github.com/nvim-telescope/telescope.nvim).
- **Syntax Highlighting** using [treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- **Automatic LSP Installation and Configuration** thanks to [Mason](https://github.com/williamboman/mason.nvim) and [lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim).
- **Autocompletion** using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with some extensions to make your life *souper*.
- **Beautiful colors** using an easy to install and configure colorscheme selector. Check `plugins/colors.lua`.
- **Git with signs** inside SoupVim thanks to [vim-fugitive](https://github.com/tpope/vim-fugitive) and [gitsigns](https://github.com/lewis6991/gitsigns.nvim).
- **Great undotree and history** using `undofile` and [undotree](https://github.com/mbbill/undotree).
