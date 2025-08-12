vim.pack.add({
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/armyers/Vim-Jinja2-Syntax",
    "https://github.com/nvim-pack/nvim-spectre",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ThePrimeagen/harpoon",
})

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0") } })
require("blink.cmp").setup({
    signature = {
        enabled = true,
        window = { show_documentation = true },
    },
    keymap = { preset = "super-tab" },
    appearance = { use_nvim_cmp_as_default = false },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
})

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "master" } })
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "go",
        "groovy",
        "helm",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },
    highlight = { enable = true },
})

vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
require("tiny-inline-diagnostic").setup({
    preset = "powerline",
    options = { show_source = true },
})

vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup({
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
})

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
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
})

vim.pack.add({
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/s1n7ax/nvim-window-picker",
})
require("neo-tree").setup({
    filesystem = {
        filtered_items = { always_show = { ".env", ".gitignore", ".helmignore", ".dockerignore" } },
    },
})

vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })
require("mini.move").setup() -- Move any selection in any direction
require("mini.bufremove").setup() -- Remove buffers
require("mini.comment").setup() -- Comment lines

-- vim.pack.add({
--     "https://github.com/norcalli/nvim-colorizer.lua",
-- })
-- local colorizer = require("colorizer")
-- colorizer.setup({ "css", "lua" }, {
--     RGB = false, -- #RGB hex codes
--     RRGGBB = true, -- #RRGGBB hex codes
--     names = false, -- "Name" codes like Blue or blue
--     RRGGBBAA = false, -- #RRGGBBAA hex codes
--     rgb_fn = false, -- CSS rgb() and rgba() functions
--     hsl_fn = true, -- CSS hsl() and hsla() functions
--     css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--     css_fn = false, -- Enable all CSS functions: rgb_fn, hsl_fn
--     mode = "background", -- Set the display mode.
--     lowercase = true, -- Enable lowercase color names
-- })
