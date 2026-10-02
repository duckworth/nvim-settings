-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "carbonfox",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.mason = {
  pkgs = { "basedpyright", "ruff", "typescript-language-server", "prettier" },
  -- Ruby LSP must use the project's Ruby and gems from PATH.
  skip = { "ruby-lsp" },
}

return M
