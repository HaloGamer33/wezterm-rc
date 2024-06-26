local wezterm = require('wezterm')
local config = {}

-- Maximize window on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function()
 local tab, pane, window = mux.spawn_window{}
 window:gui_window():maximize()
end)

if wezterm.config_builder then
  config = wezterm.config_builder()
end


config.font = wezterm.font('0xProto Nerd Font')
config.font_size = 13
config.default_prog = { 'pwsh' } -- Set Powershell

config.background = { -- Setting background
    {
        source = {
            Color = '#0C0C0C'
        },
        width = '100%',
        height = '100%',
    },
    {
        source = {
            File = 'C:/Users/HaloGamer33/.config/wezterm/wallpapers/terminal.jpg',
        },
        opacity = 0.75,
    },
}

return config
