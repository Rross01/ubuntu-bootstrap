return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } },
	{ "nvim-pack/nvim-spectre" },

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
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_foreground = "mix"
			vim.g.gruvbox_material_transparent_background = 2
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
			require("mini.splitjoin")
			require("mini.bufremove").setup() -- Remove buffers
			require("mini.comment").setup() -- Comment lines
		end,
		keys = {
			{
				"<leader>d",
				function()
					require("mini.bufremove").delete()
				end,
			},
			{
				"gS",
				function()
					require("mini.splitjoin").toggle()
				end,
			},
		},
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"fr",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
				yaml = { "yamlfmt" },
				sh = { "beautysh" },
			},
		},
	},

	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = {
			{
				"<leader>u",
				function()
					require("undotree").toggle()
				end,
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
}
