local awful = require "awful"
local bling = require "modules.bling"

bling.widget.window_switcher.enable {
  type = "thumbnail",
  hide_window_switcher_key = "Escape",
  minimize_key = "n",
  unminimize_key = "N",
  kill_client_key = "q",
  cycle_key = "Tab",
  previous_key = "Left",
  next_key = "Right",
  vim_previous_key = "h",
  vim_next_key = "l",

  cycleClientsByIdx = awful.client.focus.byidx,
  filterClients = awful.widget.tasklist.filter.currenttags,
}
