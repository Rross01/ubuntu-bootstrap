local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Neotree
map("n", "<leader>e", ":Neotree float toggle<CR>")
map("n", "<leader>E", ":Neotree float reveal<CR>")
map("n", "<leader>q", ":Neotree left toggle<CR>")
map("n", "<leader>Q", ":Neotree left reveal<CR>")

-- Telescope
map("n", "<leader>pf", ":Telescope find_files<CR>")
map("n", "<leader>pg", ":Telescope live_grep<CR>")
map("n", "<leader>pd", ":Telescope diagnostics<CR>")

-- Todo
map("n", "<leader>td", ":TodoTelescope<CR>")

-- Harpoon2
local harpoon = require("harpoon")
harpoon.setup()

map("n", "<leader>a", function()
	harpoon:list():add()
end)
map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>1", function()
	harpoon:list():select(1)
end)
map("n", "<leader>2", function()
	harpoon:list():select(2)
end)
map("n", "<leader>3", function()
	harpoon:list():select(3)
end)
map("n", "<leader>4", function()
	harpoon:list():select(4)
end)
map("n", "<leader>5", function()
	harpoon:list():select(5)
end)
map("n", "<leader>6", function()
	harpoon:list():select(6)
end)

-- Fugitive
map("n", "<leader>g", ":tab G<CR>")

-- tabclose
map("n", "<leader>D", ":tabclose<CR>")

-- My commands
local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

bind("Tmplog", "e ~/places/myself-log.md", bind_default_opts)
bind("W", "w", bind_default_opts)
bind("Q", "q", bind_default_opts)
bind("X", "x", bind_default_opts)
bind("Gca", "G commit --amend", bind_default_opts)
bind("Gp", "G push", bind_default_opts)
bind("Gpf", "G push --force", bind_default_opts)
