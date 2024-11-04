vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local api = require("nvim-tree.api")
        -- Open nvim-tree if Neovim is started with a directory
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            api.tree.open()
        end
    end,
})

-- Enable mouse support only in nvim-tree
vim.api.nvim_create_autocmd("FileType", {
    pattern = "NvimTree",
    callback = function()
        vim.opt.mouse = "a"  -- Enable mouse support
    end,
})

-- Disable mouse support when leaving nvim-tree window
vim.api.nvim_create_autocmd("WinLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "NvimTree" then
            vim.opt.mouse = ""  -- Disable mouse support
        end
    end,
})