vim.cmd("hi clear")

if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "oddsky"

if vim.o.background == "dark" then
    local oddsky_dark = require("oddsky.dark")
    oddsky_dark.set()
else
    local oddsky_light = require("oddsky.light")
    oddsky_light.set()
end
