local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "jq" },
    yaml = { "ruby_yaml" },
    xml = { "xmlformat_ruby" },
    html = { "html_tidy" },
    -- css = { "prettier" },
  },

  formatters = {
    ruby_yaml = {
      command = "ruby",
      args = { "-ryaml", "-e", "puts YAML.load($stdin.read).to_yaml" },
      stdin = true,
    },
    xmlformat_ruby = {
      command = "ruby",
      args = { "-W0", vim.fn.expand "~/.vim/xmlformat.rb" },
      stdin = true,
    },
    xmlformat_perl = {
      command = vim.fn.expand "~/.vim/xmlformat.pl",
      stdin = true,
    },
    html_tidy = {
      command = "tidy",
      args = { "-q", "-i", "--wrap", "120", "--show-errors", "0" },
      stdin = true,
      -- Tidy returns 1 when formatting succeeds with warnings.
      exit_codes = { 0, 1 },
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
