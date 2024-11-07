return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } },
	{ "nvim-pack/nvim-spectre" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme carbonfox")
		end,
	},
}
