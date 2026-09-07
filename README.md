# My Neovim Config

based on [nvchad starter](https://github.com/NvChad/starter) template

git clone git@github.com:duckworth/nvim-settings.git ~/.config/nvim

Uses Hack Nerd Font Mono, install from homebrew:

```
brew install --cask font-hack-nerd-font
```

Run :MasonInstallAll command after lazy.nvim finishes downloading plugins.
Learn customization of ui & base46 from :h nvui.

Update command:
   :Lazy update

Notes:

    ~/.config/nvim
    ├── init.lua          -- Main entry point for Neovim
    ├── lazy-lock.json    -- Tracks installed plugin versions (managed by lazy.nvim)
    └── lua
        ├── chadrc.lua     -- Primary configuration point (formerly `custom/chadrc.lua`)
        ├── configs        -- Plugin and LSP configuration files
        │   ├── conform.lua
        │   ├── lazy.lua
        │   └── lspconfig.lua
        ├── custom         -- Custom scripts and configurations
        │   └── init.lua
        ├── mappings.lua   -- Custom keybindings
        ├── options.lua    -- Neovim options (similar to `.vimrc` settings)
        └── plugins        -- Plugin setup
            └── init.lua   -- List of plugins to install
  

Customizations:

*   **Theme:** Uses the `jellybeans` theme (set in `lua/chadrc.lua`).
*   **Nvim-Tree:** Automatically opens when Neovim starts with a directory argument. Mouse support uses NvChad defaults and stays enabled in all windows. (Directory startup behavior is in `lua/custom/init.lua`.)
*   **Neovide:** New window/tab and clipboard shortcuts are in `lua/mappings.lua`.
*   **Font:** VimR manages its font in Settings > Appearance. Neovide uses `lua/options.lua`.

## Maintenance

NvChad supplies the shared editor defaults. Keep `lua/options.lua` limited to
personal overrides instead of copying those defaults. Mouse support is global;
do not toggle it when entering or leaving the file tree.

Use `:Lazy` to inspect plugins. `:Lazy update` updates installed plugins and
`lazy-lock.json`; commit the lockfile after checking the result. To undo an
update, restore the previous lockfile and run `:Lazy restore`.

VimR and terminal Neovim normally share this config, but VimR can use a bundled
Neovim version. Check `:version` in each when troubleshooting compatibility.
