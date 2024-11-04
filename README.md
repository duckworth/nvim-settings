# my nvim-settings

based on nvchad

git clone git@github.com:duckworth/nvim-settings.git ~/.config/nvim

Run :MasonInstallAll command after lazy.nvim finishes downloading plugins.
Learn customization of ui & base46 from :h nvui.

Update command:
   Lazy sync 

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
  

