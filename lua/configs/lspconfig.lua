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

-- Run ruby-lsp with the project's Ruby: bundle when the Gemfile lists it, else mise (honors .tool-versions).
vim.lsp.config("ruby_lsp", {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.uv.cwd()
    local cmd = { "ruby-lsp" }
    local gemfile = vim.fs.joinpath(root, "Gemfile")
    if vim.fn.filereadable(gemfile) == 1 and table.concat(vim.fn.readfile(gemfile), "\n"):find("ruby-lsp", 1, true) then
      cmd = { "bundle", "exec", "ruby-lsp" }
    elseif vim.fn.executable "mise" == 1 then
      cmd = { "mise", "exec", "--", "ruby-lsp" }
    end
    return vim.lsp.rpc.start(cmd, dispatchers, { cwd = root })
  end,
})

vim.lsp.enable { "html", "cssls", "ruby_lsp", "basedpyright", "ruff", "ts_ls" }
