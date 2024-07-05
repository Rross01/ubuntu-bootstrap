return {
	{
		"hrsh7th/cmp-cmdline",
		branch = "v3.x",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/nvim-cmp" },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup.cmdline({ "/", "?" }, { sources = { { name = "buffer" } } })
			cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }) })
		end,
	},
}
