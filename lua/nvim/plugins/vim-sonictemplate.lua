return {
    {
        "mattn/vim-sonictemplate",
        event = { "InsertEnter" },
        config = function()
            vim.g.sonictemplate_vim_template_dir = "~/.config/nvim/templates"
        end,
    },
}
