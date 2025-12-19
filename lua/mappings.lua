print("Mappings.lua loaded")
require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }  
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ 'n', 'i', 'v' }, '<F2>', ':NvimTreeToggle<CR>')

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


-- vim.api.nvim_set_keymap('v', '<C-^>', '"+y', { noremap = true, silent = true }) -- [94;5u 
-- vim.api.nvim_set_keymap('v', '<C-%>', '"+y', { noremap = true, silent = true }) -- [37;5u
-- vim.api.nvim_set_keymap('v', '<C-&>', '"+P', { noremap = true, silent = true }) -- [38;5u
-- vim.api.nvim_set_keymap('n', '<C-&>', '"+P', { noremap = true, silent = true }) -- [38;5u
-- vim.api.nvim_set_keymap('i', '<C-&>', '"+P', { noremap = true, silent = true }) -- [38;5u



-- https://github.com/neovide/neovide/issues/1263#issuecomment-1972013043  
-- vim.keymap.set(
--     {'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'},
--     '<D-v>',
--     function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
--     { noremap = true, silent = true }
-- )

-- JSON Formatting
map("n", "<leader>pj2", "<Esc>:%!json_xs -f json -t json-pretty<CR>:set filetype=json<CR>", opts)
map("n", "<leader>pj3", "<Esc>:%!jq '.'<CR>:set filetype=json<CR>", opts)
map("n", "<leader>pj4444", "<Esc>:%!python2 -m json.tool<CR>:set filetype=json<CR>", opts)

-- Alternative JSON formatting using Ruby
map("n", "<leader>pj", "<Esc>:%!ruby -rjson -e 'puts JSON.pretty_generate(JSON.load($<))'<CR>:set filetype=json<CR>:TSBufEnable highlight<CR>", opts)
-- YAML Formatting using Ruby
map("n", "<leader>py", "<Esc>:%!ruby -ryaml -e 'puts YAML.load($<).to_yaml'<CR>:set filetype=yaml<CR>", opts)

-- XML Formatting
map("n", "<leader>px", "<Esc>:%!ruby -W0 ~/.vim/xmlformat.rb<CR>:set filetype=xml<CR>", opts)
map("n", "<leader>px2", "<Esc>:%!~/.vim/xmlformat.pl<CR>:set filetype=xml<CR>", opts)

-- HTML Formatting using tidy
map("n", "<leader>ph", "<Esc>:%!tidy -q -i --wrap 120 --show-errors 0<CR>:set filetype=html<CR>", opts)


-- Paste-only CR/CRLF → LF normalization for VimR
-- Normalize only when CRs are present in the last inserted chunk
local grp = vim.api.nvim_create_augroup("NormalizeCROnlyOnPaste", { clear = true })

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
 group = grp,
 callback = function()
   local srow = vim.api.nvim_buf_get_mark(0, "[")[1]
   local erow = vim.api.nvim_buf_get_mark(0, "]")[1]
   if srow == 0 or erow == 0 then return end

   local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
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

   vim.api.nvim_buf_set_lines(0, srow - 1, erow, true, vim.split(norm, "\n", { plain = true }))
 end,
})
