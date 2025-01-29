return {
	"nvim-pack/nvim-spectre",
	"tpope/vim-fugitive",
	"norcalli/nvim-colorizer.lua",

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
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
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- event = "InsertEnter",
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
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_statusline_style = "original"
			vim.g.gruvbox_material_colors_override = {
				green = { "#92b937", "142" },
				bg_green = { "#92b937", "142" },
				bg1 = { "#252527", "235" },
				bg2 = { "#252527", "235" },
				bg_statusline1 = { "#252527", "235" },
			}
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
		event = "VeryLazy",
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
		opts = {
			appearance = {
				use_nvim_cmp_as_default = false,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},

	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			outline_window = {
				-- Percentage or integer of columns
				width = 20,
			},
			outline_items = {
				show_symbol_details = false,
				highlight_hovered_item = false,
			},
			symbol_folding = {
				autofold_depth = false,
				auto_unfold = { hovered = false, only = false },
			},
			guides = { enabled = false },
		},
	},
}
