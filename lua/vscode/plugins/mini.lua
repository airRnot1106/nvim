return {
    {
        "echasnovski/mini.comment",
        version = false,
        config = function()
            require("mini.comment").setup {
                mappings = {
                    comment = "<Leader>/",
                    comment_line = "<Leader>/",
                    comment_visual = "<Leader>/",
                    textobject = "<Leader>/",
                },
            }
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },
}
