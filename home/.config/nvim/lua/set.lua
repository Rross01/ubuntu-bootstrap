vim.opt.fillchars = { eob = " " }

-- don't auto commenting new lines
vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- enable word wrap
vim.opt.wrap = true

-- highlight current line
vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.number = true -- Включаем нумерацию строк
vim.opt.so = 999 -- Отступ сверху и снизу при скролинге
vim.opt.undofile = true -- Возможность отката назад
vim.opt.splitright = true -- vertical split вправо
vim.opt.splitbelow = true -- horizontal split вниз

-- Интеграция с буфером обмена ОС
vim.cmd([[ set clipboard+=unnamedplus ]])

-- Включение глобального статуса
vim.cmd([[ set laststatus=3 ]])

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
