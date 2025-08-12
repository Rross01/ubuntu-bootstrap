local map = vim.keymap.set
local bind = vim.api.nvim_create_user_command
local bind_default_opts = { bang = true }

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader><Tab>", "<C-^>")

-- nvim-neo-tree/neo-tree.nvim
map("n", "<leader>e", ":Neotree float toggle<CR>")
map("n", "<leader>E", ":Neotree float reveal<CR>")
map("n", "<leader>q", ":Neotree right toggle<CR>")
map("n", "<leader>Q", ":Neotree right reveal<CR>")

-- christoomey/vim-tmux-navigator
map("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>")
map("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>")
map("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>")
map("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>")

-- nvim-telescope/telescope.nvim
local builtin = require("telescope.builtin")
map("n", "<leader>pf", builtin.find_files)
map("n", "<leader>pg", builtin.live_grep)
map("n", "<leader>pd", builtin.diagnostics)
map("n", "<leader>pc", builtin.current_buffer_fuzzy_find)
map("n", "<leader>pb", builtin.buffers)
map("n", "<leader>ph", builtin.help_tags)

-- echasnovski/mini.nvim
map("n", "<leader>d", require("mini.bufremove").delete)
map("n", "gS", require("mini.splitjoin").toggle)

-- stevearc/conform.nvim
map("n", "fr", function()
    require("conform").format({
        async = true,
        lsp_format = "fallback",
    })
end)

-- ThePrimeagen/harpoon
local function jump(num)
    return function()
        require("harpoon.ui").nav_file(num)
    end
end
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<leader>1", jump(1))
vim.keymap.set("n", "<leader>2", jump(2))
vim.keymap.set("n", "<leader>3", jump(3))
vim.keymap.set("n", "<leader>4", jump(4))

-- custom
map("n", "<leader>D", ":tabclose<CR>")
map("n", "<leader>g", ":tab G<CR>")
map("n", "<leader>0", ":e ~/places/git/personal/second-brain/scratch.md<cr>")
bind("Tmp", "e ~/places/git/personal/second-brain/scratch.md", bind_default_opts)
bind("W", "w", bind_default_opts)
bind("Q", "q", bind_default_opts)
bind("X", "x", bind_default_opts)
bind("Gca", "G commit --amend", bind_default_opts)
bind("Gp", "G push", bind_default_opts)
bind("Gpf", "G push --force", bind_default_opts)
