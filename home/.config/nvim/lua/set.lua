-- highlight current line
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.number = true
vim.wo.relativenumber = true

vim.opt.so = 999 -- Отступ сверху и снизу при скролинге
vim.opt.undofile = true -- Возможность отката назад

-- Enable globalstatus
vim.cmd([[ set laststatus=3 ]])

-- Интеграция с буфером обмена ОС
vim.cmd([[ set clipboard+=unnamedplus ]])

-- Скрытие командной строки
vim.cmd([[ set cmdheight=0 ]])

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

-- Подсвечивает на доли секунды скопированную часть текста
vim.api.nvim_exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup end
]],
	false
)

-- Скрыть ~
vim.cmd([[ set fillchars=eob:\ ]])
