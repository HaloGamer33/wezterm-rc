local wezterm = require('wezterm')
local act = wezterm.action

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ┌─────────────────────────────────────────────────────────┐
-- │                        Asthetics                        │
-- └─────────────────────────────────────────────────────────┘

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
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
    function(tab, tabs, panes, config, hover, max_width)
        local title = tab_title(tab)
        return title
    end
)

config.color_scheme = 'Oxocarbon Dark'
config.use_fancy_tab_bar = false
config.font_size = 14
config.font = wezterm.font_with_fallback {
    '0xProto Nerd Font Mono'
}

config.background = {
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

-- Maximize window on startup
-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function()
--  local tab, pane, window = mux.spawn_window{}
--  window:gui_window():maximize()
-- end)

local is_linux = wezterm.target_triple:find("linux") ~= nil
if is_linux then
    -- config.default_prog = { '/bin/bash' }
    config.default_prog = { '/bin/zsh' }
end

config.keys = {
    { key = 'w', mods = 'ALT', action = act.CloseCurrentTab { confirm = true }, },
    { key = 'j', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = 'k', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = 't', mods = 'ALT', action = act.SpawnCommandInNewTab },
    { key = ',', mods = 'CTRL', action = act.MoveTabRelative(-1) },
    { key = '.', mods = 'CTRL', action = act.MoveTabRelative(1) },
    -- { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendString('\x1b\x7f') },
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

return config
