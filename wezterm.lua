local wezterm = require('wezterm')
local act = wezterm.action
local config = {}

-- Maximize window on startup
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function()
--  local tab, pane, window = mux.spawn_window{}
--  window:gui_window():maximize()
-- end)

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_wayland = false

config.color_scheme = 'Oxocarbon Dark'

config.use_fancy_tab_bar = false


config.keys = {
    { key = 'w', mods = 'ALT', action = act.CloseCurrentTab { confirm = true }, },
    { key = 'j', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = 'k', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = 't', mods = 'ALT', action = act.SpawnCommandInNewTab },
    { key = ',', mods = 'CTRL', action = act.MoveTabRelative(-1) },
    { key = '.', mods = 'CTRL', action = act.MoveTabRelative(1) },
    { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendString('\x17') },
    { key = 'PageUp', action = wezterm.action.ScrollByLine(-10) },
    { key = 'PageDown', action = wezterm.action.ScrollByLine(10) },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(-2),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(2),
  },
}

config.font = wezterm.font_with_fallback {
    'HackNerdFontMono',
    -- 'Weather Icons',
}
config.font_size = 14
-- config.font_size = 20 -- Temporal

local is_linux = wezterm.target_triple:find("linux") ~= nil
if is_linux then
    config.default_prog = { '/bin/bash' } -- Set Powershell
end

config.background = { -- Setting background
    {
        source = {
            Color = '#161616'
        },
        width = '100%',
        height = '100%',
    },
--     {
--         source = {
--             File = 'C:/Users/HaloGamer33/.config/wezterm/wallpapers/terminal.jpg',
--         },
--         opacity = 0.75,
--     },
}

return config
