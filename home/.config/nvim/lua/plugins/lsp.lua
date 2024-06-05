return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/nvim-cmp" },
            { "neovim/nvim-lspconfig" },
            { "saadparwaiz1/cmp_luasnip" },
            { "williamboman/mason-lspconfig.nvim" },
            { "williamboman/mason.nvim" },
            { 'towolf/vim-helm',                  ft = 'helm' },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup.cmdline({ "/", "?" }, { sources = { { name = "buffer" } } })
            cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }) })

            local lsp_zero = require("lsp-zero")
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "dockerls",
                    "docker_compose_language_service",
                    "yamlls",
                    "helm_ls",
                },
                handlers = { lsp_zero.default_setup, },
            })

            local lspconfig = require('lspconfig')

            -- setup helm-ls
            lspconfig.helm_ls.setup {
                settings = {
                    ['helm-ls'] = {
                        yamlls = {
                            path = "yaml-language-server",
                        }
                    }
                }
            }
        end,
    },
}
