return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        cond = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme rose-pine-moon]]
        end,
    },
}