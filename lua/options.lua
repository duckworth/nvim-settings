require "nvchad.options"

local opt = vim.opt

-- Personal preferences beyond NvChad's defaults.
opt.relativenumber = false
opt.wrap = true
opt.scrolloff = 3
opt.termguicolors = true
opt.hlsearch = true
opt.incsearch = true
vim.g.have_nerd_font = true

-- Keep NvChad's mouse support enabled in the editor and file tree.
-- VimR manages its font in Settings > Appearance.
if vim.g.neovide then
  opt.guifont = "Hack Nerd Font Mono:h13.00"
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_input_use_logo = true
end
