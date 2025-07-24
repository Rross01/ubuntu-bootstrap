return {
    "tpope/vim-fugitive",
    "armyers/Vim-Jinja2-Syntax",
    "nvim-pack/nvim-spectre",

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        opts = {
            filesystem = {
                filtered_items = { always_show = { ".env", ".gitignore", ".helmignore", ".dockerignore" } },
            },
        },
    },

    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
            "TmuxNavigatorProcessList",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            local colorizer = require("colorizer")
            colorizer.setup({ "css", "lua" }, {
                RGB = false, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue or blue
                RRGGBBAA = false, -- #RRGGBBAA hex codes
                rgb_fn = false, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false, -- Enable all CSS functions: rgb_fn, hsl_fn
                mode = "background", -- Set the display mode.
                lowercase = true, -- Enable lowercase color names
            })
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        opts = {
            scope = { enabled = false },
            indent = {
                -- weird way to hide first line
                highlight = {
                    "@transparent",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                    "VertSplit",
                },
                char = "▏",
            },
        },
    },

    {
        "echasnovski/mini.nvim",
        version = false,
        event = "VeryLazy",
        config = function()
            require("mini.move").setup() -- Move any selection in any direction
            require("mini.bufremove").setup() -- Remove buffers
            require("mini.comment").setup() -- Comment lines
        end,
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            formatters = {
                stylua = {
                    prepend_args = { "--indent-type", "Spaces" },
                },
                cbfmt = {
                    prepend_args = { "--config", "/home/rrossamakhin/.config/nvim/cbfmt.toml" },
                },
            },
            formatters_by_ft = {
                lua = { "stylua" },
                python = {
                    "ruff_format",
                    "ruff_organize_imports",
                    "ruff_fix",
                },
                sh = { "beautysh" },
                zsh = { "beautysh" },
                sql = { "sqlfmt" },
                json = { "fixjson" },
                markdown = { "prettier", "cbfmt" },
                toml = { "taplo" },
                go = { "gofumpt" },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "bash",
                "go",
                "helm",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "vim",
                "vimdoc",
                "yaml",
            },
            highlight = { enable = true },
        },
    },

    -- lsp stuff - setup in lsp.lua file
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "towolf/vim-helm", ft = "helm" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "L3MON4D3/LuaSnip" },
            { "mfussenegger/nvim-lint" },
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        opts = {
            preset = "powerline",
            options = { show_source = true },
        },
        event = "VeryLazy",
        priority = 1000,
    },

    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            signature = { enabled = true },
            keymap = { preset = "super-tab" },
            appearance = {
                use_nvim_cmp_as_default = false,
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },
        },
    },
}
