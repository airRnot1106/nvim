return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-j>",
                        next = "<C-]>",
                        prev = "<C-[>",
                        dismiss = "<C-e>",
                    },
                },
            }
        end,
    },
}
