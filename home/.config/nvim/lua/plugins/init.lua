return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "windwp/nvim-autopairs", config = true },
	{ "s1n7ax/nvim-window-picker", config = true },
	{ "brenoprata10/nvim-highlight-colors", config = true },
	{ "tpope/vim-fugitive" },
	{ "nvim-pack/nvim-spectre" },
	{ "powerman/vim-plugin-ruscmd" },
	{ "lepture/vim-jinja" },

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- {
	--     'MeanderingProgrammer/markdown.nvim',
	--     dependencies = { 'nvim-treesitter/nvim-treesitter' },
	--     config = function()
	--         require('render-markdown').setup({})
	--     end,
	-- },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
					theme = "custom",
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 }, "diff", "diagnostics" },
					lualine_x = { "branch" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { scope = { enabled = false } },
	},

	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
				transparent = true,
				code_style = {
					functions = "bold",
				},
			})
			vim.cmd.colorscheme("onedark")
		end,
	},

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },

	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Autohighlight word under cursor
			require("mini.cursorword").setup()
			-- Move any selection in any direction
			require("mini.move").setup()
			-- Split and join arguments
			require("mini.splitjoin").setup()
			-- Remove buffers
			require("mini.bufremove").setup()
			-- Comment lines
			require("mini.comment").setup({ ignore_blank_line = false })
		end,
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
			format_on_save = {
				timeout_ms = 500,
			},
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
		keys = { { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" } },
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
			})
		end,
	},
}
