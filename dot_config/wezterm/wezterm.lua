local wezterm = require 'wezterm'

local config = {
  font = wezterm.font 'JetBrainsMono Nerd Font',
  font_size = 9.0,
  color_scheme = 'Sandcastle (base16)',
  window_background_opacity = 1,
  audible_bell = 'Disabled',
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'wsl.exe', '~' }
end

config.visual_bell = {
  fade_in_duration_ms = 75,
  fade_out_duration_ms = 75,
  target = 'CursorColor',
}

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local dims = window:get_dimensions()
  local scale = dims.dpi / 96.0  -- 96 DPI is standard baseline

  if scale < 1.2 then
    overrides.font_size = 9.0  -- normal monitor
  elseif scale < 1.8 then
    overrides.font_size = 9.0  -- 1440p or medium DPI
  else
    overrides.font_size = 9.0  -- 4K or high-DPI monitor
  end

  window:set_config_overrides(overrides)
end)

return config
