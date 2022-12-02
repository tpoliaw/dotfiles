local wezterm = require 'wezterm';

return {
  color_scheme = "Gruvbox Dark",
  audible_bell = "Disabled",
  check_for_updates = false,
  font = wezterm.font_with_fallback({
      'Iosevka SS14',
      'Font Awesome 6 Free'
  }),
  font_size = 12,
  exit_behavior = "Close",
  adjust_window_size_when_changing_font_size = false,
  enable_tab_bar = false,
  window_padding = {
    left = 5,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

