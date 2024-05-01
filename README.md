## Installation

```sh
git clone https://github.com/manokii/nvim.git ~/.config/nvim
```

> [!Note]
> Note, this will fail if you have an existing `~/.config/nvim` folder

After cloning, just run `nvim` and it should automatically install all dependencies.

## File Structure

```
 .
├──  init.lua              - Init File, this file runs at startup
├──  lazy-lock.json        - Lua lockfile
├──  lua                   - Config directory
│  ├──  autocmds.lua       - Autocmds are stored here for convenience
│  ├──  colors.lua         - Anything related to colors/hl
│  ├──  mappings.lua       - Keymaps
│  ├──  options.lua        - Vim options
│  ├──  plugins
│  │  ├──  cmp.lua         - Autocomplete plugin
│  │  ├──  conform.lua     - Formatter plugin
│  │  ├──  lint.lua        - Linter plugins
│  │  ├──  lspconfig.lua   - LSP plugins (Language Server Protocol)
│  │  ├──  telescope.lua   - Fuzzy Finder
│  │  ├──  treesitter.lua  - Syntax Highlighting
│  │  ├──  ui.lua          - UI related plugins (noice, lualine, whichkey, tokyonight, gitsigns, nvim-tree)
│  │  └──  utils.lua       - Utility plugins (vim-sleuth, vim-visual-multi, Comment, autopairs, todo-comments, mini)
│  └──  utils
│     ├──  etc.lua         - Other utility functions, used for mapping keybinds
│     ├──  gitsigns.lua    - Gitsigns related utility functions
│     ├──  telescope.lua   - Telescope related utility functions
│     └──  term.lua        - Utility for opening/hiding terminals, similar to NvChad (popup, vertical, horizontal)
└──  README.md             - this
```

## Keymap

Just hit `<leader>ch`, it'll will open a cheatsheet, cc: [NvChad/ui](https://github.com/NvChad/ui)
![Cheatsheet screenshot](https://i.imgur.com/fBOkulw.png)

## Credits

This config is a mix of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and [NvChad/ui](https://github.com/NvChad/ui)
