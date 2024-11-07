return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false, -- Disable lazy loading
    config = function()
      require("nvim-tree").setup {
        -- Ensures `nvim-tree` opens in a side panel
        view = {
          side = "left",
          width = 30, -- Adjust width as needed
        },
        -- Opens the tree when entering a directory in Neovim
        sync_root_with_cwd = true, -- Ensures directory structure matches current working directory
        -- Keeps the tree focused on the current file
        respect_buf_cwd = true,
        -- Automatically refreshes and updates the tree when opening a project
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        -- Controls behavior when opening directories
        hijack_directories = {
          enable = true,
        },
        open_on_tab = false,
      }
    end,
  },
  {
    "doums/dark.nvim",
    lazy = false,
    priority = 1000,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
