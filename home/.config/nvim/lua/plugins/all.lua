return {
	"norcalli/nvim-colorizer.lua",
	"nvim-pack/nvim-spectre",
	"tpope/vim-fugitive",

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
				green = { "#a7b837", "142" },
				bg_green = { "#a7b837", "142" },
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

	-- Interactive popup
	--
	-- When using ChatGPT and ChatGPTEditWithInstructions, the following keybindings are available:
	--
	--     <C-Enter> [Both] to submit.
	--     <C-y> [Both] to copy/yank last answer.
	--     <C-o> [Both] Toggle settings window.
	--     <C-h> [Both] Toggle help window.
	--     <Tab> [Both] Cycle over windows.
	--     <C-f> [Chat] Cycle over modes (center, stick to right).
	--     <C-c> [Both] to close chat window.
	--     <C-p> [Chat] Toggle sessions list.
	--     <C-u> [Chat] scroll up chat window.
	--     <C-d> [Chat] scroll down chat window.
	--     <C-k> [Chat] to copy/yank code from last answer.
	--     <C-n> [Chat] Start new session.
	--     <C-r> [Chat] draft message (create message without submitting it to server)
	--     <C-r> [Chat] switch role (switch between user and assistant role to define a workflow)
	--     <C-s> [Both] Toggle system message window.
	--     <C-i> [Edit Window] use response as input.
	--     <C-d> [Edit Window] view the diff between left and right panes and use diff-mode commands
	--
	-- When the setting window is opened (with <C-o>), settings can be modified by pressing Enter on the related config. Settings are saved across sections
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			local config = {
				api_host_cmd = "echo -n chat-gpt.nau.im",
				api_key_cmd = "echo foobar",
				ignore_default_actions_path = true,
				actions_paths = {
					"~/.config/nvim/lua/plugins/chatgpt_actions.json",
				},
			}
			require("chatgpt").setup(config)
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim", -- optional
			"nvim-telescope/telescope.nvim",
		},
	},
}
