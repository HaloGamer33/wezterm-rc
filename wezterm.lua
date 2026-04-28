local wezterm = require('wezterm')
local act = wezterm.action

if wezterm.config_builder then
  Config = wezterm.config_builder()
end

-- ┌─────────────────────────────────────────────────────────┐
-- │                        Asthetics                        │
-- └─────────────────────────────────────────────────────────┘

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return string.format(' %i ', tab_info.tab_index + 1)
end

wezterm.on(
    'format-tab-title',
    function(tab)
        local title = tab_title(tab)
        return title
    end
)

Config.hide_tab_bar_if_only_one_tab = true
Config.color_scheme = 'Oxocarbon Dark'
Config.use_fancy_tab_bar = false
Config.font_size = 14
Config.font = wezterm.font_with_fallback {
    '0xProto Nerd Font Mono'
}

Config.background = {
    {
        source = {
            Color = '#161616'
        },
        width = '100%',
        height = '100%',
    },
    {
        source = {
            File = '/home/halo/Wallpaper/wallhaven-o5rjq9.png'
        },
    },
}

-- ┌─────────────────────────────────────────────────────────┐
-- │                          Logic                          │
-- └─────────────────────────────────────────────────────────┘

local is_linux = wezterm.target_triple:find("linux") ~= nil
if is_linux then
    Config.default_prog = { '/bin/zsh' }
end

Config.keys = {
    { key = ',', mods = 'CTRL', action = act.MoveTabRelative(-1) },
    { key = '.', mods = 'CTRL', action = act.MoveTabRelative(1) },
    { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendString('\x17') },
    { key = 'PageUp', action = wezterm.action.ScrollByLine(-10) },
    { key = 'PageDown', action = wezterm.action.ScrollByLine(10) },
}

Config.mouse_bindings = {
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

return Config
