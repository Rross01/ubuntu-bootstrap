return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "tpope/vim-fugitive" },
	{ "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } },
	{ "nvim-pack/nvim-spectre" },
	{ "mrjones2014/smart-splits.nvim" },

	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			char = "|",
			virtcolumn = "88",
			highlight = "IblIndent",
		},
	},

	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local opts = { markdown_header_marks = true }
			require("monokai-nightasty").load(opts)
			vim.cmd("colorscheme monokai-nightasty")
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
	},

	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				openai_api_key = "foobar",
				providers = {
					openai = {
						endpoint = "https://chat-gpt.nau.im/v1/chat/completions",
						secret = "foobar",
					},
				},
			}
			require("gp").setup(conf)
		end,
	},

	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		opts = {
			width = 150,
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = { enabled = false },
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
