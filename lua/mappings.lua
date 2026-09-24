require "nvchad.mappings"

-- add yours here

-- vim-tmux-navigator (override NvChad's Ctrl-h/l window switching)
local map = vim.keymap.set
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left (tmux/vim)" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down (tmux/vim)" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up (tmux/vim)" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right (tmux/vim)" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>rr", "<cmd>luafile %<cr>", { desc = "Reload current file" })
map({ "n", "i", "v" }, "<F2>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Neovide-specific settings
if vim.g.neovide then -- vim.fn.has('macunix') then
  map('n', '<D-s>', ':w<CR>') -- Save
  map('v', '<D-c>', '"+y') -- Copy
  map('n', '<D-v>', '"+P') -- Paste normal mode
  map('v', '<D-v>', '"+P') -- Paste visual mode
  map('c', '<D-v>', '<C-R>+') -- Paste command mode
  map('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  map("n", "<D-n>", ":silent exec '!open --new -b com.neovide.neovide --args ${PWD}'<cr>")
  map('n', '<D-t>', ':enew<CR>')
  map({'i', 'v'}, '<D-t>', '<ESC>:enew<CR>')
end

-- https://github.com/neovide/neovide/issues/1263#issuecomment-1972013043  
-- vim.keymap.set(
--     {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
--     '<D-v>',
--     function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
--     { noremap = true, silent = true }
-- )

local function map_formatter(key, filetype, formatter)
  map("n", "<leader>" .. key, function()
    local bufnr = vim.api.nvim_get_current_buf()
    require("conform").format({
      bufnr = bufnr,
      formatters = { formatter },
      lsp_format = "never",
      timeout_ms = 3000,
    }, function(err)
      if not err then
        vim.bo[bufnr].filetype = filetype
      end
    end)
  end, { desc = "Format " .. filetype, silent = true })
end

-- Keep the existing JSON shortcuts as aliases for jq.
for _, key in ipairs { "pj", "pj2", "pj3", "pj4444" } do
  map_formatter(key, "json", "jq")
end
map_formatter("py", "yaml", "ruby_yaml")
map_formatter("px", "xml", "xmlformat_ruby")
map_formatter("px2", "xml", "xmlformat_perl")
map_formatter("ph", "html", "html_tidy")

-- Diffview (git diffs)
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git diff view" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File git history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo git history" })


-- Paste-only CR/CRLF → LF normalization for VimR
-- Normalize only when CRs are present in the last inserted chunk
local grp = vim.api.nvim_create_augroup("NormalizeCROnlyOnPaste", { clear = true })
local normalize_cr_on_paste_busy = false

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
 group = grp,
 callback = function(args)
   if normalize_cr_on_paste_busy then return end

   local bufnr = args.buf
   if not vim.api.nvim_buf_is_valid(bufnr) then return end

   local line_count = vim.api.nvim_buf_line_count(bufnr)
   if line_count == 0 then return end

   local srow = vim.api.nvim_buf_get_mark(bufnr, "[")[1]
   local erow = vim.api.nvim_buf_get_mark(bufnr, "]")[1]
   if srow == 0 or erow == 0 then return end

   srow = math.min(math.max(srow, 1), line_count)
   erow = math.min(math.max(erow, 1), line_count)
   if erow < srow then return end

   local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, srow - 1, erow, false)
   if not ok then return end
   if #lines == 0 then return end

   -- Quick bail: only act if the change included a CR (you won't type this)
   local has_cr = false
   for i = 1, #lines do
     if lines[i]:find("\r", 1, true) then has_cr = true; break end
   end
   if not has_cr then return end

   -- Normalize: CRLF -> LF, then lone CR -> LF
   local chunk = table.concat(lines, "\n")
   local norm  = chunk:gsub("\r\n", "\n"):gsub("\r", "\n")
   if norm == chunk then return end

   normalize_cr_on_paste_busy = true
   pcall(vim.api.nvim_buf_set_lines, bufnr, srow - 1, erow, false, vim.split(norm, "\n", { plain = true }))
   normalize_cr_on_paste_busy = false
 end,
})
