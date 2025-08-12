local map = vim.keymap.set

-- exit terminal mode
map("t", "<C-\\>", "<C-\\><C-n>")

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader><Tab>", "<C-^>")

-- Neotree
map("n", "<leader>e", ":Neotree float toggle<CR>")
map("n", "<leader>E", ":Neotree float reveal<CR>")
map("n", "<leader>q", ":Neotree right toggle<CR>")
map("n", "<leader>Q", ":Neotree right reveal<CR>")

-- christoomey/vim-tmux-navigator
map("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")
map("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>")

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>pf", builtin.find_files)
map("n", "<leader>pg", builtin.live_grep)
map("n", "<leader>pd", builtin.diagnostics)
map("n", "<leader>pc", builtin.current_buffer_fuzzy_find)
map("n", "<leader>pb", builtin.buffers)
map("n", "<leader>ph", builtin.help_tags)

-- mini
map("n", "<leader>d", require("mini.bufremove").delete)
map("n", "gS", require("mini.splitjoin").toggle)

-- conform
map("n", "fr", function()
    require("conform").format({
        async = true,
        lsp_format = "fallback",
    })
end)

-- Harpoon2
local harpoon = require("harpoon")
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
map("n", "<leader>7", function()
    harpoon:list():select(7)
end)
map("n", "<leader>8", function()
    harpoon:list():select(8)
end)

map("n", "<leader>0", ":e ~/places/git/personal/second-brain/scratch.md<cr>")

-- Fugitive
map("n", "<leader>g", ":tab G<CR>")

-- Tabclose
map("n", "<leader>D", ":tabclose<CR>")

-- My commands
local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

bind("Tmp", "e ~/places/git/personal/second-brain/scratch.md", bind_default_opts)
bind("W", "w", bind_default_opts)
bind("Q", "q", bind_default_opts)
bind("X", "x", bind_default_opts)
bind("Gca", "G commit --amend", bind_default_opts)
bind("Gp", "G push", bind_default_opts)
bind("Gpf", "G push --force", bind_default_opts)
