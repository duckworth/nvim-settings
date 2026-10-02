-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("basedpyright", {
  before_init = function(_, config)
    if config.root_dir then
      local python = vim.fs.joinpath(config.root_dir, ".venv", "bin", "python")
      if vim.fn.executable(python) == 1 then
        config.settings.python = vim.tbl_extend("force", config.settings.python or {}, { pythonPath = python })
      end
    end
  end,
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- Ruff handles import actions.
      analysis = { diagnosticMode = "openFilesOnly" },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false -- Use basedpyright for hover information.
  end,
})

vim.lsp.enable { "html", "cssls", "ruby_lsp", "basedpyright", "ruff", "ts_ls" }
