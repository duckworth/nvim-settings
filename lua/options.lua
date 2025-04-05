require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline
local opt = vim.opt
opt.mouse = ""
-- Core Settings
opt.number = true                 -- Show line numbers
opt.relativenumber = false         -- Relative line numbers
opt.wrap = true                    -- Enable line wrapping
opt.scrolloff = 3                  -- Keep 3 lines of context around cursor
opt.tabstop = 2                    -- Set tab width to 2 spaces
opt.shiftwidth = 2                 -- Indentation width of 2 spaces
opt.expandtab = true               -- Use spaces instead of tabs
opt.clipboard = "unnamedplus"      -- Use system clipboard
opt.cursorline = true              -- Highlight current line
opt.termguicolors = true           -- Enable true colors
opt.hlsearch = true                -- Highlight search matches
opt.incsearch = true               -- Incremental search
opt.ignorecase = true              -- Case-insensitive search
opt.smartcase = true               -- Case-sensitive if uppercase used

-- nvchad based theme is set in chadrc.lua
-- vim.cmd([[colorscheme dark]])
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#151515" })
vim.g.have_nerd_font = true

-- Check if Neovide or VimR is running
if vim.g.neovide or vim.fn.exists("g:gui_vimr") then
    opt.guifont = "Hack Nerd Font Mono:h13.00"

    -- Neovide specific settings
    if vim.g.neovide then
        opt.mouse = "a" -- Enable mouse support
        vim.g.neovide_cursor_vfx_mode = "railgun" -- Optional, visual effect
        vim.g.neovide_input_use_logo = true -- Enable Cmd as <D->
    end
    -- VimR specific settings
    if vim.fn.exists("g:gui_vimr") then
        
    end
end

-- if vim.g.neovide or vim.g.vimr then