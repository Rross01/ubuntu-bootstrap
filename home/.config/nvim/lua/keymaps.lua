local map = vim.api.nvim_set_keymap
local map2 = vim.keymap.set
local map_default_opts = { noremap = true, silent = true }

local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Neotree
map("n", "<leader>e", ":Neotree float toggle<CR>", map_default_opts)
map("n", "<leader>E", ":Neotree float reveal<CR>", map_default_opts)
map("n", "<leader>q", ":Neotree right toggle<CR>", map_default_opts)
map("n", "<leader>Q", ":Neotree right reveal<CR>", map_default_opts)

-- Telescope
map("n", "<leader>pf", ":Telescope find_files<CR>", map_default_opts)
map("n", "<leader>pg", ":Telescope live_grep<CR>", map_default_opts)
map("n", "<leader>pd", ":Telescope diagnostics<CR>", map_default_opts)

-- Todo
map("n", "<leader>td", ":TodoTelescope<CR>", map_default_opts)

-- Harpoon2
local harpoon = require("harpoon")
harpoon.setup()

map2("n", "<leader>a", function()
	harpoon:list():add()
end)
map2("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map2("n", "<leader>1", function()
	harpoon:list():select(1)
end)
map2("n", "<leader>2", function()
	harpoon:list():select(2)
end)
map2("n", "<leader>3", function()
	harpoon:list():select(3)
end)
map2("n", "<leader>4", function()
	harpoon:list():select(4)
end)
map2("n", "<leader>5", function()
	harpoon:list():select(5)
end)
map2("n", "<leader>6", function()
	harpoon:list():select(6)
end)

-- gitsigns
map("n", "<leader>tb", ":Gitsigns blame_line<CR>", map_default_opts)

-- Fugitive
map("n", "<leader>g", ":tab G<CR>", map_default_opts)

-- tabclose
map("n", "<leader>D", ":tabclose<CR>", map_default_opts)

-- My commands
bind("Tmplog", "e ~/places/myself-log.md", bind_default_opts)
bind("W", "w", bind_default_opts)
bind("Q", "q", bind_default_opts)
bind("X", "x", bind_default_opts)
bind("Gca", "G commit --amend", bind_default_opts)
bind("Gp", "G push", bind_default_opts)
bind("Gpf", "G push --force", bind_default_opts)
bind("Gb", "G branch", bind_default_opts)

bind("Table", "'<,'>!column --table --separator ' '", bind_default_opts)
bind("Flatten", "'<,'>!tr -d '[:space:]'", bind_default_opts)
