return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
            "MasonUpdate",
        },
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "neovim/nvim-lspconfig" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lspconfig = require "lspconfig"
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    local opts = {
                        on_attach = function(client)
                            -- Reference highlight
                            if client.supports_method "textDocument/documentHighlight" then
                                vim.cmd [[
                                  set updatetime=200
                                  highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guibg=#104040
                                  highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guibg=#104040
                                ]]
                                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                    group = vim.api.nvim_create_augroup("lsp_document_highlight_on_hold", {}),
                                    callback = function()
                                        vim.lsp.buf.document_highlight()
                                    end,
                                })
                                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                    group = vim.api.nvim_create_augroup("lsp_document_highlight_on_moved", {}),
                                    callback = function()
                                        vim.lsp.buf.clear_references()
                                    end,
                                })
                            end
                        end,
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                    }

                    if server_name == "lua_ls" then
                        opts.settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                format = {
                                    enable = false,
                                },
                            },
                        }
                    end

                    -- Debug setup
                    -- print("Setting up " .. server_name)
                    -- print(vim.inspect(opts))

                    lspconfig[server_name].setup(opts)
                end,
            }

            -- LSP keymaps
            local keymap = vim.api.nvim_set_keymap
            keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
            keymap("n", "gf", "<Cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
            keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
            keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
            keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
            keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
            keymap("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = true })
            keymap("n", "gn", "<Cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
            keymap("n", "<F2>", "<Cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
            keymap("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
            keymap("n", "<Leader>.", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
            keymap("n", "ge", "<Cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
            keymap("n", "g]", "<Cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
            keymap("n", "g[", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

            -- Diagnostic float
            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = vim.api.nvim_create_augroup("diagnostic_float", {}),
                callback = function()
                    vim.diagnostic.open_float { focusable = false }
                end,
            })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
            { "nvimtools/none-ls.nvim" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local null_ls = require "null-ls"
            null_ls.setup()
            require("mason-null-ls").setup {
                -- Enter here the tools you have installed
                ensure_installed = {
                    "stylua",
                },
                automatic_setup = false,
                handlers = {},
            }
        end,
    },
    {

        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "v2.*",
        build = "make install_jsregexp",
        event = { "InsertEnter" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load {
                paths = {
                    -- friendly-snippets
                    vim.fn.stdpath "data" .. "/lazy/friendly-snippets",
                    -- custom snippets
                    "~/.config/nvim/snippets",
                },
            }
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        event = { "InsertEnter" },
        config = function()
            local cmp = require "cmp"
            local map = cmp.mapping
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = map.preset.insert {
                    ["<C-d>"] = map.scroll_docs(-4),
                    ["<C-f>"] = map.scroll_docs(4),
                    ["<C-Space>"] = map.complete(),
                    ["<C-e>"] = map.abort(),
                    ["<CR>"] = map.confirm { select = false },
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            }

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
