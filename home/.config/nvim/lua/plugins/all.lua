return {
	"tpope/vim-fugitive",
	"nvim-pack/nvim-spectre",
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } },
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
			indent = { highlight = "IblIndent", char = "▏" },
		},
	},

	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_show_eob = 0
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

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
			default_component_configs = {
				indent = { padding = 0 },
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰜌",
				},
			},
		},
	},

	{
		"echasnovski/mini.nvim",
		version = false,
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
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				sh = { "beautysh" },
			},
		},
	},

	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = {
				"bash",
				"helm",
				"json",
				"jsonc",
				"lua",
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
		branch = "v3.x",
		dependencies = {
			{ "towolf/vim-helm", ft = "helm" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "williamboman/mason.nvim" },
			{ "L3MON4D3/LuaSnip" },
			{ "mfussenegger/nvim-lint" },
		},
	},

	{
		"saghen/blink.cmp",
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts_extend = { "sources.default" },
	},
}
