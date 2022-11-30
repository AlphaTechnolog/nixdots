local menubar = require "menubar"

terminal = "kitty --single-instance"
explorer = "thunar"
browser = "firefox"
LauncherObject = require "ui.appslauncher"
launcher = "rofi -show drun"
editor = os.getenv("EDITOR") or "vim"
visual_editor = "code" -- vscode
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4" -- super, the windows key
Mod1 = "Mod1"

-- Set the terminal for applications that require it
menubar.utils.terminal = terminal
