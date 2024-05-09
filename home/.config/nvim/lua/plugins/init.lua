return {
    { "lewis6991/gitsigns.nvim",            config = true },
    { 'windwp/nvim-autopairs',              config = true },
    { 's1n7ax/nvim-window-picker',          config = true },
    { 'brenoprata10/nvim-highlight-colors', config = true },
    { "tpope/vim-fugitive" },
    { 'nvim-pack/nvim-spectre' },
    { 'powerman/vim-plugin-ruscmd' },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = { { 'filename', path = 1, }, 'diff', 'diagnostics' },
                    lualine_c = { 'branch' },
                    lualine_x = { 'filetype' },
                    lualine_y = { 'location' },
                    lualine_z = {}
                },
            }
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = { scope = { enabled = false }, },
    },

    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('onedark').setup {
                style = 'dark',
                transparent = false,
                toggle_style_key = '<leader>ts',
                toggle_style_list = { 'dark', 'darker', 'warm', 'warmer', 'light' },
            }
            require('onedark').load()
            vim.cmd('colorscheme onedark')
        end,
    },

    -- {
    --     'HoNamDuong/hybrid.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         vim.cmd('colorscheme hybrid')
    --     end,
    -- },

    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.cursorword').setup()
            require('mini.move').setup()
            require('mini.splitjoin').setup()
            require('mini.bufremove').setup()
            require('mini.comment').setup({ ignore_blank_line = false, })
        end,
    },

    -- {
    --     'codota/tabnine-nvim',
    --     build = "./dl_binaries.sh",
    --     event = "VeryLazy",
    --     config = function()
    --         require('tabnine').setup({
    --             disable_auto_comment = true,
    --             accept_keymap = "<C-w>",
    --             dismiss_keymap = "<C-e>",
    --             debounce_ms = 800,
    --             suggestion_color = { gui = "#808080", cterm = 244 },
    --             exclude_filetypes = { "TelescopePrompt", "neo-tree" },
    --             log_file_path = nil, -- absolute path to Tabnine log file
    --         })
    --     end,
    -- },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                yaml = { "yamlfmt" },
                sh = { "beautysh" }
            },
        },
    },

    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" } },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                highlight = { enable = true },
            }
        end
    },
}
