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
local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()
local default_setup = function(server)
	require("lspconfig")[server].setup({
		capabilities = lsp_capabilities,
	})
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- python
		"pyright",
		"ruff",
		-- other
		"dockerls",
		"helm_ls",
		"lua_ls",
		"yamlls",
	},
	handlers = { default_setup },
})

local lspconfig = require("lspconfig")
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
					"D100",
					"D105",
					"D107",
					"FBT001",
					"FBT002",
					"INP001",
					"RUF001",
					"RUF002",
					"RUF003",
					"TRY003",
					"ANN002",
					"ANN003",
				},
				pydocstyle = {
					convention = "google",
					ignore_var_parameters = true,
				},
			},
		},
	},
})
