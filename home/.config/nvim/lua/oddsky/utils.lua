local M = {}

local nvim_set_hl = function(ns_id)
    return function(name, val)
        vim.api.nvim_set_hl(ns_id, name, val)
    end
end

M.highlight = nvim_set_hl(0)

-- M.classic = {
--   name = 'monokai',
--   base0 = '#222426',
--   base1 = '#272a30',
--   base2 = '#26292C',
--   base3 = '#2E323C',
--   base4 = '#333842',
--   base5 = '#4d5154',
--   base6 = '#9ca0a4',
--   base7 = '#b1b1b1',
--   base8 = '#e3e3e1',
--   border = '#a1b5b1',
--   brown = '#504945',
--   white = '#f8f8f0',
--   grey = '#8F908A',
--   black = '#000000',
--   red = '#e95678',
--   orange = '#fd971f',
--   yellow = '#e6db74',
--   green = '#a6e22e',
--   aqua = '#66d9ef',
--   purple = '#ae81ff',
--   pink = '#f92672',
--   diff_add = '#3d5213',
--   diff_remove = '#4a0f23',
--   diff_change = '#27406b',
--   diff_text = '#23324d',
-- }

-- {
--   "colors": {
--     "brand": {
--       50: "#E1FAEF",
--       100: "#C2F4DF",
--       200: "#86EABE",
--       300: "#49DF9E",
--       400: "#22BF7B",
--       500: "#178254",
--       600: "#126843",
--       700: "#0E4E32",
--       800: "#093421",
--       900: "#051A11",
--       950: "#020D08"
--     }
--   }
-- }

M.gen_colors = function()
    return {
        -- base16
        red_dark = "#E01B24",
        red_light = "#C01C28",
        orange_dark = "#FFA348",
        orange_light = "#d65900",
        yellow_dark = "#F6D32D",
        yellow_light = "#D38B09",
        green_dark = "#57E389",
        green_light = "#007a3d",
        blue_dark = "#62A0EA",
        blue_light = "#0049A3",
        purple_dark = "#DC8ADD",
        purple_light = "#9141AC",
        teal_dark = "#5BC8AF",
        teal_light = "#267582",
        violet_dark = "#7D8AC7",
        violet_light = "#4E57BA",

        -- extras
        search_light = "#F9F7D2",
        search_dark = "#F5C211",
        visual_dark = "#193D66",
        visual_light = "#99C1F1",
        dark_1 = "#77767B",
        dark_2 = "#5E5C64",
        dark_3 = "#504E55",
        dark_4 = "#404040",
        dark_5 = "#1c1c1c", -- dark bg
        light_1 = "#FCFCFC", -- light bg
        light_2 = "#F6F5F4",
        light_3 = "#E5E4E1",
        light_4 = "#C0BFBC",
        light_5 = "#9A9996",
    }
end

return M
