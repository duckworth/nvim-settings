vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local api = require("nvim-tree.api")
        -- Open nvim-tree if Neovim is started with a directory
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            api.tree.open()
        end
    end,
})

if not vim.g.neovide then
    vim.opt.mouse = "a"
end
