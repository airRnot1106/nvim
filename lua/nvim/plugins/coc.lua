return {
    {
        "neoclide/coc.nvim",
        branch = "release",
        build = "coc#util#install",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local keymap = vim.api.nvim_set_keymap
            keymap(
                "i",
                "<CR>",
                'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><C-r>=coc#on_enter()<CR>"',
                { expr = true, noremap = true, silent = true }
            )
            keymap(
                "i",
                "<Esc>",
                'coc#pum#visible() ? coc#pum#cancel() : "<Esc>"',
                { expr = true, noremap = true, silent = true }
            )
            keymap("n", "<C-k>", "<Cmd>call CocActionAsync('doHover')<CR>", { noremap = true, silent = true })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = vim.api.nvim_create_augroup("coc_hover", {}),
                callback = function()
                    vim.api.nvim_command "call CocActionAsync('doHover')"
                end,
            })
        end,
    },
}
