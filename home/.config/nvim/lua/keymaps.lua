local map = vim.keymap.set
local map2 = map
local map_default_opts = { noremap = true, silent = true }

local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

bind("GPT", ":GpChatNew tabnew", bind_default_opts)

bind("Table", "'<,'>!column --table --separator ' '", bind_default_opts)
bind("Flatten", "'<,'>!tr -d '[:space:]'", bind_default_opts)
