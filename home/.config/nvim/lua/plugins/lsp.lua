return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "towolf/vim-helm", ft = "helm" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
		},
		config = function()
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
					"yamlls",
					"helm_ls",
				},
				handlers = { lsp_zero.default_setup },
			})

			local lspconfig = require("lspconfig")

			-- setup helm-ls
			lspconfig.helm_ls.setup({
				settings = {
					["helm-ls"] = { yamlls = { path = "yaml-language-server" } },
				},
			})
		end,
	},
}
