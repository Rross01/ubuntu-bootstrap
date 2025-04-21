-- Функция для получения значения из gsettings
local function get_gnome_color_scheme()
	local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
	if not handle then
		return nil
	end
	local result = handle:read("*a")
	handle:close()
	if result then
		result = result:gsub("%s+", ""):gsub("'", "")
		return result
	end
	return nil
end

local scheme = get_gnome_color_scheme()

if scheme == "prefer-dark" then
    vim.opt.background = "dark"
else
    vim.opt.background = "light"
end
