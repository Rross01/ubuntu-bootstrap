local hl = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

local M = {}

local function hsl_to_hex(h, s, l)
    local function hue2rgb(p, q, t)
        if t < 0 then
            t = t + 1
        end
        if t > 1 then
            t = t - 1
        end
        if t < 1 / 6 then
            return p + (q - p) * 6 * t
        end
        if t < 1 / 2 then
            return q
        end
        if t < 2 / 3 then
            return p + (q - p) * (2 / 3 - t) * 6
        end
        return p
    end

    h = h / 360

    local r, g, b

    if s == 0 then
        r, g, b = l, l, l -- achromatic (grey)
    else
        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end

    local function tohex(x)
        return string.format("%02x", math.floor(x * 255 + 0.5))
    end

    return "#" .. tohex(r) .. tohex(g) .. tohex(b)
end

-- stylua: ignore start
M.dark_colors = {
    red         =  hsl_to_hex(357,  0.78,  0.49),
    orange      =  hsl_to_hex(30,   1,     0.64),
    yellow      =  hsl_to_hex(50,   0.92,  0.57),
    green       =  hsl_to_hex(141,  0.65,  0.62),
    blue        =  hsl_to_hex(213,  0.76,  0.65),
    purple      =  hsl_to_hex(299,  0.55,  0.70),
    teal        =  hsl_to_hex(166,  0.50,  0.57),
    violet      =  hsl_to_hex(229,  0.4,   0.64),
    search      =  hsl_to_hex(47,   0.60,  0.25),
    visual      =  hsl_to_hex(212,  0.60,  0.25),
    bg_1        =  hsl_to_hex(0,    0,     0.11),
    bg_2        =  hsl_to_hex(0,    0,     0.25),
    bg_3        =  hsl_to_hex(0,    0,     0.32),
    bg_4        =  hsl_to_hex(0,    0,     0.38),
    bg_5        =  hsl_to_hex(0,    0,     0.47),
    fg_5        =  hsl_to_hex(0,    0,     0.60),
    fg_4        =  hsl_to_hex(0,    0,     0.75),
    fg_3        =  hsl_to_hex(0,    0,     0.89),
    fg_2        =  hsl_to_hex(0,    0,     0.96),
    fg_1        =  hsl_to_hex(0,    0,     0.99),
    git_add     =  hsl_to_hex(80,   0.62,  0.20),
    git_remove  =  hsl_to_hex(340,  0.66,  0.17),
    git_change  =  hsl_to_hex(218,  0.47,  0.29),
}

M.light_colors = {
    red         =  hsl_to_hex(356,  0.75,  0.43),
    orange      =  hsl_to_hex(25,   1,     0.42),
    yellow      =  hsl_to_hex(39,   0.92,  0.43),
    green       =  hsl_to_hex(150,  1,     0.24),
    blue        =  hsl_to_hex(213,  1,     0.32),
    purple      =  hsl_to_hex(285,  0.45,  0.46),
    teal        =  hsl_to_hex(188,  0.55,  0.33),
    violet      =  hsl_to_hex(235,  0.44,  0.52),
    search      =  hsl_to_hex(57,   0.70,  0.90),
    visual      =  hsl_to_hex(213,  0.70,  0.90),
    bg_1        =  hsl_to_hex(0,    0,     0.99),
    bg_2        =  hsl_to_hex(0,    0,     0.96),
    bg_3        =  hsl_to_hex(0,    0,     0.89),
    bg_4        =  hsl_to_hex(0,    0,     0.75),
    bg_5        =  hsl_to_hex(0,    0,     0.60),
    fg_5        =  hsl_to_hex(0,    0,     0.47),
    fg_4        =  hsl_to_hex(0,    0,     0.38),
    fg_3        =  hsl_to_hex(0,    0,     0.32),
    fg_2        =  hsl_to_hex(0,    0,     0.25),
    fg_1        =  hsl_to_hex(0,    0,     0.11),
    git_add     =  hsl_to_hex(140,  0.92,  0.43),
    git_remove  =  hsl_to_hex(356,  0.92,  0.43),
    git_change  =  hsl_to_hex(39,   0.92,  0.43),
}
-- stylua: ignore end

M.set = function(colors)
    -- UI highlight
    hl("Normal", { fg = colors.fg_3, bg = colors.bg_1 })
    hl("NormalFloat", { fg = colors.fg_3, bg = colors.bg_2 })
    hl("FloatBorder", { fg = colors.bg_5, bg = colors.bg_2 })
    hl("ColorColumn", { bg = colors.bg_2 })
    hl("Cursor", { fg = colors.bg_5, bg = colors.fg_4 })
    hl("CursorLine", { bg = colors.bg_3 })
    hl("CursorColumn", { bg = colors.bg_3 })
    hl("Directory", { fg = colors.fg_2, bold = true })
    hl("DiffAdd", { fg = colors.teal })
    hl("DiffChange", { fg = colors.orange })
    hl("DiffDelete", { fg = colors.red })
    hl("DiffText", { fg = colors.orange })
    hl("EndOfBuffer", { fg = colors.bg_1 })
    hl("ErrorMsg", { fg = colors.red, underline = true })
    hl("VertSplit", { fg = colors.bg_4 })
    hl("WinSeparator", { link = "VertSplit" })
    hl("Folded", { fg = colors.fg_5 })
    hl("FoldColumn", { fg = colors.fg_5 })
    hl("SignColumn", { fg = colors.fg_4 })
    hl("IncSearch", { fg = colors.fg_2, bg = colors.search })
    hl("LineNr", { fg = colors.bg_3 })
    hl("CursorLineNr", { fg = colors.bg_5, bg = colors.bg_2 })
    hl("MatchParen", { fg = colors.fg_3, bold = true })
    hl("ModeMsg", { fg = colors.fg_3, bg = colors.bg_2 })
    hl("MoreMsg", { fg = colors.fg_3, bg = colors.bg_2 })
    hl("NonText", { fg = colors.fg_5 })
    hl("Pmenu", { fg = colors.fg_3, bg = colors.bg_2 })
    hl("PmenuSel", { fg = colors.fg_4, bg = colors.bg_5 })
    hl("PmenuSbar", { bg = colors.fg_5 })
    hl("PmenuThumb", { bg = colors.bg_5 })
    hl("Question", { fg = colors.blue })
    hl("Search", { fg = colors.fg_2, bg = colors.search })
    hl("SpecialKey", { fg = colors.fg_4 })
    hl("StatusLine", { fg = colors.fg_3, bg = colors.bg_2 })
    hl("StatusLineNC", { fg = colors.fg_3, bg = colors.bg_3 })
    hl("TabLine", { fg = colors.fg_3, bg = colors.bg_3 })
    hl("TabLineFill", { fg = colors.fg_3, bg = colors.bg_3 })
    hl("TablineSel", { fg = colors.fg_3, bg = colors.bg_1 })
    hl("Title", { bold = true })
    hl("Visual", { bg = colors.visual })
    hl("VisualNOS", { bg = colors.visual })
    hl("WarningMsg", { fg = colors.yellow, bold = true })
    hl("WildMenu", { fg = colors.fg_3, bg = colors.blue })
    hl("Comment", { fg = colors.fg_5 })
    hl("Constant", { fg = colors.violet })
    hl("String", { fg = colors.teal })
    hl("Character", { fg = colors.teal })
    hl("Number", { fg = colors.violet })
    hl("Boolean", { fg = colors.purple })
    hl("Float", { fg = colors.violet })
    hl("Identifier", { fg = colors.orange })
    hl("Function", { fg = colors.blue })
    hl("Statement", { fg = colors.purple })
    hl("Conditional", { fg = colors.orange, bold = true })
    hl("Repeat", { fg = colors.purple })
    hl("Label", { fg = colors.purple })
    hl("Operator", { fg = colors.fg_3 })
    hl("Keyword", { fg = colors.orange, bold = true })
    hl("Exception", { fg = colors.orange })
    hl("PreProc", { fg = colors.violet })
    hl("Include", { fg = colors.orange, bold = true })
    hl("Define", { fg = colors.yellow, bold = true })
    hl("Macro", { fg = colors.yellow, bold = true })
    hl("Type", { fg = colors.teal, bold = true })
    hl("StorageClass", { fg = colors.teal, bold = true })
    hl("Typedef", { fg = colors.teal, bold = true })
    hl("Structure", { fg = colors.yellow })
    hl("Special", { fg = colors.red })
    hl("SpecialChar", { fg = colors.red })
    hl("Tag", { fg = colors.teal })
    hl("Delimiter", { fg = colors.fg_3 })
    hl("SpecialComment", { fg = colors.fg_5 })
    hl("Debug", { fg = colors.fg_3 })
    hl("Underlined", { underline = true })
    hl("Ignore", { fg = colors.fg_3 })
    hl("Error", { fg = colors.red, underline = true })
    hl("Todo", { fg = colors.orange, bold = true })
    hl("SpellBad", { fg = colors.red, underline = true, sp = colors.red })
    hl("SpellCap", { fg = colors.red, underline = true, sp = colors.red })
    hl("SpellRare", { fg = colors.red, underline = true, sp = colors.red })
    hl("SpellLocale", { fg = colors.red, underline = true, sp = colors.red })
    hl("Whitespace", { fg = colors.bg_5 })

    --- Treesitter highlight
    hl("@error", { fg = colors.red })
    hl("@text.literal", { fg = colors.fg_3 })
    hl("@text.literal.markdown", { fg = colors.fg_3 })
    hl("@text.literal.markdown.inline", { fg = colors.fg_3 })
    hl("@text.title", { fg = colors.teal, bold = true })
    hl("@text.emphasis", { italic = true })
    hl("@text.strong", { bold = true })
    hl("@text.uri", { fg = colors.blue, underline = true })
    hl("@textReference", { fg = colors.blue })
    hl("@text.underline", { underline = true })
    hl("@text.todo", { fg = colors.orange, bold = true })
    hl("@text.note", { fg = colors.green, bold = true })
    hl("@text.warning", { fg = colors.yellow, bold = true })
    hl("@text.danger", { fg = colors.red, bold = true })
    hl("@comment", { fg = colors.fg_5, italic = true })
    hl("@punctuation", { fg = colors.fg_3 })
    hl("@punctuation.special", { fg = colors.teal })
    hl("@punctuation.bracket", { fg = colors.fg_3 })
    hl("@punctuation.delimiter", { fg = colors.fg_3 })
    hl("@constant", { fg = colors.fg_3 })
    hl("@constant.macro", { fg = colors.yellow, bold = true })
    hl("@define", { fg = colors.yellow, bold = true })
    hl("@macro", { fg = colors.yellow, bold = true })
    hl("@string", { fg = colors.teal })
    hl("@string.escape", { fg = colors.blue })
    hl("@stringEscape", { fg = colors.blue })
    hl("@string.special", { fg = colors.blue })
    hl("@string.regex", { fg = colors.purple })
    hl("@character", { fg = colors.teal })
    hl("@character.special", { fg = colors.blue })
    hl("@number", { fg = colors.violet })
    hl("@boolan", { fg = colors.violet, bold = true })
    hl("@float", { fg = colors.teal })
    hl("@function", { fg = colors.green })
    hl("@function.builtin", { fg = colors.blue })
    hl("@function.macro", { fg = colors.blue, bold = true })
    hl("@attribute", { fg = colors.orange })
    hl("@annotation", { fg = colors.yellow })
    hl("@parameter", { fg = colors.orange })
    hl("@parameter.reference", { fg = colors.orange })
    hl("@method", { fg = colors.blue })
    hl("@field", { fg = colors.teal })
    hl("@property", { fg = colors.blue })
    hl("@constructor", { fg = colors.fg_3 })
    hl("@conditional", { fg = colors.orange, bold = true })
    hl("@repeat", { fg = colors.orange, bold = true })
    hl("@label", { fg = colors.purple })
    hl("@operator", { fg = colors.purple })
    hl("@keyword", { fg = colors.red })
    hl("@keyword.function", { fg = colors.blue })
    hl("@keyword.operator", { fg = colors.orange })
    hl("@exception", { fg = colors.orange, bold = true })
    hl("@variable", { fg = colors.fg_2 })
    hl("@variable.builtin", { fg = colors.purple })
    hl("@variable.parameter", { fg = colors.fg_3 })
    hl("@variable.other", { fg = colors.teal })
    hl("@type", { fg = colors.yellow })
    hl("@type.builtin", { fg = colors.teal })
    hl("@type.qualifire", { fg = colors.teal })
    hl("@type.definition", { fg = colors.teal, bold = true })
    hl("@storageclass", { fg = colors.orange, bold = true })
    hl("@structure", { fg = colors.teal, bold = true })
    hl("@namespace", { fg = colors.orange })
    hl("@include", { fg = colors.orange, bold = true })
    hl("@preproc", { fg = colors.orange })
    hl("@debug", { fg = colors.yellow })
    hl("@tag", { fg = colors.teal })
    hl("@tag.delimiter", { fg = colors.fg_3 })
    hl("@tag.attribute", { fg = colors.orange })

    -- python
    hl("@variable.member.python", { fg = colors.blue })
    hl("@function.call.python", { fg = colors.green })

    -- LSP semantic tokens
    hl("@lsp.type.class", { link = "@type" })
    hl("@lsp.type.decorator", { link = "@function" })
    hl("@lsp.type.enum", { link = "@structure" })
    hl("@lsp.type.enumMember", { link = "@property" })
    hl("@lsp.type.function", { link = "@function" })
    hl("@lsp.type.interface", { link = "@type" })
    hl("@lsp.type.macro", { link = "@macro" })
    hl("@lsp.type.method", { link = "@function" })
    hl("@lsp.type.namespace", { link = "@namespace" })
    hl("@lsp.type.parameter", { link = "@parameter" })
    hl("@lsp.type.property", { link = "@property" })
    hl("@lsp.type.struct", { link = "@structure" })
    hl("@lsp.type.type", { link = "@type" })
    hl("@lsp.type.typeParameter", { link = "@type" })
    hl("@lsp.type.variable", { link = "@variable" })
    hl("@lsp.type.keyword", { link = "@keyword" })

    hl("htmlTag", { fg = colors.teal })
    hl("htmlEndTag", { fg = colors.teal })
    hl("htmlTagName", { fg = colors.teal })
    hl("htmlSpecialTagName", { fg = colors.teal })
    hl("htmlArg", { fg = colors.orange })

    hl("NvimTreeRootFolder", { fg = colors.fg_3 })
    hl("NvimTreeFolderIcon", { fg = colors.fg_3 })
    hl("NvimTreeFolderName", { fg = colors.fg_3, bold = true })
    hl("NvimTreeEmptyFolderName", { fg = colors.fg_3, bold = true })
    hl("NvimTreeOpenedFolderName", { fg = colors.fg_3, bold = true })
    hl("NvimTreeVertSplit", { fg = colors.bg_1 })
    hl("NvimTreeNormal", { bg = colors.bg_1 })
    hl("NvimTreeEndOfBuffer", { fg = colors.bg_1, bg = colors.bg_1 })

    hl("BufferLineIndicatorSelected", { bg = colors.bg_1 })
    hl("BufferLineFill", { bg = colors.bg_2 })

    -- Telescope nvim
    hl("TelescopePromptBorder", { fg = colors.bg_5 })
    hl("TelescopeResultsBorder", { fg = colors.bg_5 })
    hl("TelescopePreviewBorder", { fg = colors.bg_5 })
    hl("TelescopeNormal", { fg = colors.fg_3 })
    hl("TelescopeSelection", { fg = colors.fg_3, bg = colors.bg_3 })
    hl("TelescopeMultiSelection", { fg = colors.fg_3 })
    hl("TelescopeMatching", { fg = colors.fg_3, bold = true })
    hl("TelescopePromptPrefix", { fg = colors.fg_3, bold = true })

    hl("LspReferenceText", { bg = colors.search })
    hl("LspReferenceRead", { bg = colors.blue })
    hl("LspReferenceWrite", { bg = colors.blue })
    hl("DiagnosticError", { fg = colors.red })
    hl("DiagnosticWarn", { fg = colors.yellow })
    hl("DiagnosticHint", { fg = colors.blue })
    hl("DiagnosticInfo", { fg = colors.teal })

    hl("CocHighlightText", { bg = colors.blue })
    hl("CocHighlightRead", { bg = colors.blue })
    hl("CocHighlightWrite", { bg = colors.blue })

    hl("CmpItemKind", { fg = colors.fg_3 })

    -- Typescript fix
    hl("typescriptParens", { fg = colors.bg_3, bg = "NONE" })

    -- A custome thing to make cmp doc border invisible
    hl("CmpNDocBorder", { fg = colors.bg_5, bg = colors.bg_1 })

    hl("GitSignsAdd", { fg = colors.git_add })
    hl("GitSignsChange", { fg = colors.git_change })
    hl("GitSignsDelete", { fg = colors.git_remove })

    -- neotree
    hl("NeoTreeDirectoryName", { fg = colors.fg_2 })
    hl("NeoTreeDirectoryIcon", { fg = colors.fg_2 })
    hl("NeoTreeFloatBorder", { fg = colors.bg_5, bg = colors.bg_1 })

    hl("IblIndent", { fg = colors.bg_3 })
    hl("IblIndentBlank", { fg = colors.bg_1 })
end

M.setup = function()
    vim.cmd("hi clear")

    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end

    vim.o.termguicolors = true
    vim.g.colors_name = "oddsky"

    if vim.o.background == "dark" then
        M.set(M.dark_colors)
    else
        M.set(M.light_colors)
    end
end
return M
