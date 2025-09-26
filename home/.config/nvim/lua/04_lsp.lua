vim.pack.add({
    "https://github.com/towolf/vim-helm",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/mfussenegger/nvim-lint",
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }
        local map = vim.keymap.set
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        map({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    end,
})

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
})

vim.diagnostic.config({
    virtual_text = false,
    unerline = false,
    float = {
        header = false,
        border = "rounded",
        focusable = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
})

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover({
        border = "rounded",
        -- max_width = 100,
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.7),
    })
end

require("mason").setup({})
require("mason-tool-installer").setup({
    ensure_installed = {
        -- lsp's
        "gopls",
        "helm_ls",
        "lua_ls",
        "pyright",
        "yaml-language-server",
        -- formatters
        "beautysh",
        "cbfmt",
        "fixjson",
        "gofumpt",
        "ruff",
        "sqlfmt",
        "stylua",
        "taplo",
    },
    start_delay = 3000, -- 3 second delay
})

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.gopls.setup({})
lspconfig.yamlls.setup({})

-- Fix Undefined global 'vim'
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig.helm_ls.setup({
    settings = {
        ["helm-ls"] = { yamlls = { path = "yaml-language-server" } },
    },
})

lspconfig.ruff.setup({
    init_options = {
        settings = {
            lint = {
                select = { "ALL" },
                ignore = {
                    -- whole group
                    "BLE",
                    "COM",
                    "D",
                    "FBT",
                    "FIX",
                    "INP",
                    "TD",
                    "ERA",
                    -- specific rule
                    "ANN002",
                    "ANN003",
                    "ANN101",
                    "ANN201",
                    "ANN202",
                    "ANN204",
                    "ANN205",
                    "ARG001",
                    "ARG002",
                    "DTZ005",
                    "F841",
                    "LOG015",
                    "N803",
                    "N806",
                    "PGH003",
                    "PLW0603",
                    "RUF001",
                    "RUF002",
                    "RUF003",
                    "S110",
                    "S112",
                    "SIM102",
                    "TC001",
                    "TRY003",
                    "TRY400",
                    "UP032",
                },
                pydocstyle = {
                    convention = "google",
                    ignore_var_parameters = true,
                },
            },
        },
    },
})
