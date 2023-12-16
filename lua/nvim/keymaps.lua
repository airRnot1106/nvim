local keymap = vim.api.nvim_set_keymap

-- leader
vim.g.mapleader = " "

-- mode
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- cursor
keymap("n", "k", "gk", { noremap = true, silent = true })
keymap("n", "j", "gj", { noremap = true, silent = true })
keymap("x", "k", "gk", { noremap = true, silent = true })
keymap("x", "j", "gj", { noremap = true, silent = true })
keymap("n", "K", "10k", { noremap = true, silent = true })
keymap("n", "J", "10j", { noremap = true, silent = true })
keymap("x", "K", "10k", { noremap = true, silent = true })
keymap("x", "J", "10j", { noremap = true, silent = true })

-- edit
keymap("n", "x", '"_x', { noremap = true, silent = true })
keymap("n", "X", '"_X', { noremap = true, silent = true })
keymap("n", "s", '"_s', { noremap = true, silent = true })
keymap("n", "S", '"_S', { noremap = true, silent = true })
keymap("n", "c", '"_c', { noremap = true, silent = true })
keymap("n", "C", '"_C', { noremap = true, silent = true })
keymap("n", "d", '"_d', { noremap = true, silent = true })
keymap("n", "D", '"_D', { noremap = true, silent = true })
keymap("n", "<C-d>", "dd", { noremap = true, silent = true })
keymap("x", "x", '"_x', { noremap = true, silent = true })
keymap("x", "X", '"_X', { noremap = true, silent = true })
keymap("x", "s", '"_s', { noremap = true, silent = true })
keymap("x", "S", '"_S', { noremap = true, silent = true })
keymap("x", "c", '"_c', { noremap = true, silent = true })
keymap("x", "C", '"_C', { noremap = true, silent = true })
keymap("x", "d", '"_d', { noremap = true, silent = true })
keymap("x", "D", '"_D', { noremap = true, silent = true })
keymap("x", "<C-d>", "d", { noremap = true, silent = true })

-- buffer
keymap("n", "<Leader>w", ":w<CR>", { noremap = true, silent = true })

-- filer
keymap("n", "<Leader>e", "<Cmd>Fern . -reveal=% -drawer -toggle -width=40<CR>", { noremap = true, silent = true })
keymap("n", "<leader>o", "", {
    callback = function()
        if vim.bo.filetype == "fern" then
            vim.cmd.wincmd "p"
        else
            vim.cmd.Fern(".", "-reveal=%", "-drawer", "-width=40")
        end
    end,
    noremap = true,
    silent = true,
})
