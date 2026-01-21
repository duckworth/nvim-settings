-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config using vim.lsp.config API
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
  vim.lsp.enable(lsp)
end

-- configuring single server, example: typescript
-- vim.lsp.config.ts_ls = {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
-- vim.lsp.enable('ts_ls')
