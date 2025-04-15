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

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false,
	virtual_text = false,
})

vim.diagnostic.config({
	virtual_text = false,
	unerline = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

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
					-- whole group
					"BLE",
					"COM",
					"D",
					"FBT",
					"FIX",
					"INP",
					"TD",
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
