return {
	"tpope/vim-fugitive",
	"armyers/Vim-Jinja2-Syntax",
	"norcalli/nvim-colorizer.lua",
	"nvim-pack/nvim-spectre",

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		opts = {
			preset = "powerline",
			transparent_bg = false,
			options = { show_source = true },
		},
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
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
		event = "InsertEnter",
		event = "VeryLazy",
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
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_foreground = "mix"
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
		event = "VeryLazy",
		config = function()
			require("mini.move").setup() -- Move any selection in any direction
			require("mini.bufremove").setup() -- Remove buffers
			require("mini.comment").setup() -- Comment lines
			require("mini.pairs").setup()
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
				sql = { "sqlfmt" },
				json = { "fixjson" },
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
		opts = {
			keymap = { preset = "super-tab" },
			appearance = {
				use_nvim_cmp_as_default = false,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
