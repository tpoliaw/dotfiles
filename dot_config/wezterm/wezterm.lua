local wezterm = require("wezterm")
wezterm.on("update-status", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.colors = window:effective_config().colors
  if window:is_focused() then
    overrides.colors["background"] = nil
  else
    overrides.colors["background"] = "#3c3838"
  end

  window:set_config_overrides(overrides)
end)

hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(hyperlink_rules, {
  -- Jira tickets
  regex = "[A-Z]+[0-9_]*-\\d+",
  format = "https://jira.diamond.ac.uk/browse/$0",
})
table.insert(hyperlink_rules, {
  -- Match gerrit change ids and map to a query. Can't link directly
  -- to change as id is not unique (across cherry-picks etc)
  regex = "Change-Id: (I[a-f0-9]{40})",
  format = "https://gerrit.diamond.ac.uk/q/change:$1",
})

return {
  color_scheme = "GruvboxDark",
  -- Highlight the cursor when the compose key is waiting for input
  colors = { compose_cursor = "orange" },
  -- Why would a terminal making a noise be a good idea?
  audible_bell = "Disabled",
  -- While there is a bug in 20220624
  check_for_updates = false,
  show_update_window = false,
  font = wezterm.font_with_fallback({
    "Iosevka SS14",
    "Iosevka Nerd Font Mono",
    "FiraCode Nerd Font Mono",
    "Font Awesome 6 Free",
  }),
  font_size = 12,
  -- Don't send notifications when fonts don't render correctly
  warn_about_missing_glyphs = false,
  -- Don't prevent the window closing when the final command failed
  exit_behavior = "Close",
  -- When increasing the size of font, reduce the row/column count instead
  -- of trying to resize the window (which fails in i3)
  adjust_window_size_when_changing_font_size = false,
  enable_tab_bar = false,
  -- Launch menu isn't shown when the tab bar is enabled, but if it was...
  launch_menu = {
    {
      args = { "btm" },
    },
  },
  window_padding = {
    left = 5,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- Enable additional features in applications that support them
  term = "wezterm",
  -- Set double clicking to not select :; characters
  selection_word_boundary = " \t\n{}[]()\"'`,:;",
  hyperlink_rules = hyperlink_rules,
  keys = {
    -- Disable the default Ctrl-PageUp/Down keys so that they can be used in tmux
    -- Default in wezterm is switch tabs which I don't use
    { key = "PageUp", mods = "CTRL", action = "DisableDefaultAssignment" },
    { key = "PageDown", mods = "CTRL", action = "DisableDefaultAssignment" },
  },
  disable_default_mouse_bindings = true,
  mouse_bindings = {
    -- Double left click => select by word
    {
      event = { Down = { streak = 2, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.SelectTextAtMouseCursor("Word"),
    },
    {
      event = { Drag = { streak = 2, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.ExtendSelectionToMouseCursor("Word"),
    },
    {
      event = { Up = { streak = 2, button = "Left" } },
      mods = "NONE",
      action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = "PrimarySelection" }),
    },

    -- Single left click => select by cell
    {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.SelectTextAtMouseCursor("Cell"),
    },
    {
      event = { Drag = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.ExtendSelectionToMouseCursor("Cell"),
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = "PrimarySelection" }),
    },

    -- Single right click => clear selection
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action.ClearSelection,
    },

    -- Middle click paste support
    {
      event = { Down = { streak = 1, button = "Middle" } },
      mods = "NONE",
      action = wezterm.action.PasteFrom("PrimarySelection"),
    },
    -- Scroll wheel support
    -- {
    --   event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    --   mods = "NONE",
    --   mouse_reporting = Any,
    --   alt_screen = true,
    --   action = wezterm.action.ScrollByCurrentEventWheelDelta,
    -- },
    -- {
    --   event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    --   mods = "NONE",
    --   -- mouse_reporting = true,
    --   alt_screen = true,
    --   action = wezterm.action.ScrollByCurrentEventWheelDelta,
    -- },
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = "NONE",
      mouse_reporting = false,
      alt_screen = false,
      action = wezterm.action.ScrollByCurrentEventWheelDelta,
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = "NONE",
      mouse_reporting = false,
      alt_screen = false,
      action = wezterm.action.ScrollByCurrentEventWheelDelta,
    },
  },
}
