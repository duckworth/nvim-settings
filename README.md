# my nvim-settings


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
    ├── mappings.lua   -- Custom keybindings
    ├── options.lua    -- Neovim options (similar to `.vimrc` settings)
    └── plugins        -- Plugin setup
        └── init.lua   -- List of plugins to install
