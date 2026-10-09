return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- herdr relays kitty graphics but snacks cannot identify it as a supported terminal
      image = { enabled = true, force = vim.env.TERM_PROGRAM == "herdr" },
      gitbrowse = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Open LazyGit",
      },
      {
        "<leader>gb",
        function()
          Snacks.gitbrowse { what = "file" }
        end,
        mode = { "n", "x" },
        desc = "Open file on GitHub",
      },
      {
        "<leader>ih",
        function()
          Snacks.image.hover()
        end,
        desc = "Preview image under cursor",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    config = function()
      local pkgs = vim.deepcopy(require("chadrc").mason.pkgs)
      vim.list_extend(pkgs, { "stylua" })
      require("mason-tool-installer").setup {
        ensure_installed = pkgs,
        auto_update = true,
        run_on_start = true,
      }
    end,
  },
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
        on_attach = function(bufnr)
          local api = require "nvim-tree.api"
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "<LeftRelease>", api.node.open.edit, { buffer = bufnr })
        end,
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
          update_root = true,
        },
        -- Controls behavior when opening directories
        hijack_directories = {
          enable = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
        tab = {
          sync = {
            open = false,
            close = false,
          },
        },
      }
    end,
  },
  {
    "doums/dark.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    opts = {
      -- NvChad's TSInstallAll reads this table to install parsers with the new API.
      ensure_installed = {
        "lua",
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "ruby",
        "python",
        "javascript",
        "typescript",
        "tsx",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle Markdown rendering" },
    },
    opts = {
      enabled = true,
      render_modes = { "n", "c", "t" },
      anti_conceal = { enabled = true },
    },
  },
  -- {
  --   "Exafunction/windsurf.vim",
  --   event = "BufEnter",
  -- },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },
}
