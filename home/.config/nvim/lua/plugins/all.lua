return {
	"tpope/vim-fugitive",
	"armyers/Vim-Jinja2-Syntax",
	"nvim-pack/nvim-spectre",

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		opts = {
			preset = "powerline",
			-- transparent_bg = false,
			options = { show_source = true },
		},
		event = "VeryLazy",
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
		event = "VeryLazy",
		opts = {
			scope = { enabled = false },
			indent = { highlight = "IblIndent", char = "▏" },
		},
	},

	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_foreground = "original"
	-- 		vim.g.gruvbox_material_show_eob = 0
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },

	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		config = function()
			-- Default options
			require("github-theme").setup({
				options = {
					styles = {
						comments = "italic",
					},
				},
			})

			-- setup must be called before loading
			vim.cmd("colorscheme github_dark")
			-- Функция для получения значения из gsettings
			local function get_gnome_color_scheme()
				local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
				if not handle then
					return nil
				end
				local result = handle:read("*a")
				handle:close()
				if result then
					result = result:gsub("%s+", ""):gsub("'", "")
					return result
				end
				return nil
			end

			local scheme = get_gnome_color_scheme()

			if scheme == "prefer-dark" then
				vim.opt.background = "dark"
				vim.cmd("colorscheme github_dark")
			else
				vim.opt.background = "light"
				vim.cmd("colorscheme github_light")
			end
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
			filesystem = {
				filtered_items = {
					always_show = {
						".env",
						".gitignore",
						".helmignore",
						".dockerignore",
					},
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
			require("mini.cursorword").setup()
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = {
					"ruff_format",
					"ruff_organize_imports",
					"ruff_fix",
				},
				sh = { "beautysh" },
				sql = { "sqlfmt" },
				json = { "fixjson" },
				markdown = { "prettier" },
				toml = { "taplo" },
				go = { "gofumpt" },
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
		dependencies = {
			{ "towolf/vim-helm", ft = "helm" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
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
