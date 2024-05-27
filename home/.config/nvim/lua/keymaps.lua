local map = vim.api.nvim_set_keymap
local map2 = vim.keymap.set
local map_default_opts = { noremap = true, silent = true }

local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

-- Закрытие текущего буфера
map("n", "<leader>d", "[[<cmd>lua MiniBufremove.delete()<cr>", map_default_opts)

-- Выход из режима терминала
map("i", "jj", "<Esc>", map_default_opts)
map("i", "оо", "<Esc>", map_default_opts)

-- Вставка по Space+p, предотвращая копирование замененного текста в буфер
map("x", "<leader>p", '"_dP', map_default_opts)

-- Переименовать слово под которым курсор
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], map_default_opts)

-- По fs очищаем последний поиск с подсветкой
map("n", "fs", ":nohl<CR>", map_default_opts)

-- Neotree
map("n", "<leader>e", ":Neotree float toggle<CR>", map_default_opts)
map("n", "<leader>E", ":Neotree float reveal<CR>", map_default_opts)
map("n", "<leader>q", ":Neotree right toggle<CR>", map_default_opts)
map("n", "<leader>Q", ":Neotree right reveal<CR>", map_default_opts)

-- Telescope
map("n", "<leader>pf", ":Telescope find_files<CR>", map_default_opts)
map("n", "<leader>pg", ":Telescope live_grep<CR>", map_default_opts)
map("n", "<leader>pc", ":Telescope grep_string<CR>", map_default_opts)
map("n", "<leader>pd", ":Telescope diagnostics<CR>", map_default_opts)
map("n", "<leader>H", ":Telescope help_tags<CR>", map_default_opts)
map("n", "<leader>b", ":Telescope buffers<CR>", map_default_opts)

-- formatter
map("n", "fr", ":Format<CR>", map_default_opts)

-- Harpoon2
local harpoon = require("harpoon")
harpoon.setup()

map2("n", "<leader>a", function() harpoon:list():add() end)
map2("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map2("n", "<leader>1", function() harpoon:list():select(1) end)
map2("n", "<leader>2", function() harpoon:list():select(2) end)
map2("n", "<leader>3", function() harpoon:list():select(3) end)
map2("n", "<leader>4", function() harpoon:list():select(4) end)
map2("n", "<leader>5", function() harpoon:list():select(5) end)
map2("n", "<leader>6", function() harpoon:list():select(6) end)

map2("n", "<tab>", function() harpoon:list():prev() end)
map2("n", "<s-tab>", function() harpoon:list():next() end)

-- gitsigns
map("n", "<leader>tb", ":Gitsigns blame_line<CR>", map_default_opts)

-- easy split navigation
map("n", "<C-h>", "<C-w>h", map_default_opts)
map("n", "<C-l>", "<C-w>l", map_default_opts)
map("n", "<C-j>", "<C-w>j", map_default_opts)
map("n", "<C-k>", "<C-w>k", map_default_opts)

-- Fugitive
-- map("n", "<leader>g", ":tab G | vsplit<CR>", map_default_opts)
map("n", "<leader>g", ":tab G<CR>", map_default_opts)

-- tabclose
map("n", "<leader>D", ":tabclose<CR>", map_default_opts)

-- My commands
bind('Tmplog', "e ~/places/work/myself-log/log.md", bind_default_opts)
bind('W', "w", bind_default_opts)
bind('Q', "q", bind_default_opts)
bind('X', "x", bind_default_opts)
bind('Gca', "G commit --amend", bind_default_opts)
bind('Gp', "G push", bind_default_opts)
bind('Gpf', "G push --force", bind_default_opts)
bind('Gb', "G branch", bind_default_opts)

bind('Table', "'<,'>!column --table --separator ' '", bind_default_opts)
bind('Flatten', "'<,'>!tr -d '[:space:]'", bind_default_opts)
