-- highlight current line
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.number = true
vim.wo.relativenumber = true

vim.opt.scrolloff = 999
vim.opt.undofile = true -- Возможность отката назад

-- Интеграция с буфером обмена ОС
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Скрытие командной строки
vim.cmd([[ set cmdheight=0 ]])

vim.opt.laststatus = 3
vim.opt.statusline = " %f %m %= %l:%c"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Табы и отступы
vim.opt.syntax = "ON"
vim.opt.smartindent = true -- autoindent new lines
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 4 -- shift 4 spaces when tab
vim.opt.tabstop = 4 -- 1 tab == 4 spaces

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
