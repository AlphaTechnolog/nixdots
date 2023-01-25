-- Colors from: https://github.com/enkia/tokyo-night-vscode-theme

local style = require "core.style"
local common = require "core.common"

style.background = { common.color "#101419" }
style.background2 = { common.color "#0e1217" }
style.background3 = { common.color "#1a1e23" }
style.text = { common.color "#b6beca" }
style.caret = { common.color "#b6beca" }
style.accent = { common.color "#78dba9" } -- Text in autocomplete and command, col(>80) in satusbar
style.dim = { common.color "#242931" } -- Text of nonactive tabs, prefix in log
style.divider = { common.color "#13171c" }
style.selection = { common.color "#242931" }
style.line_number = { common.color "#242931" }
style.line_number2 = { common.color "#b6beca" } -- Number on line with caret
style.line_highlight = { common.color "#101419"}
style.scrollbar = { common.color "#242931" }
style.scrollbar2 = { common.color "#485263" } -- Hovered

style.syntax["normal"] = { common.color "#b6beca" }
style.syntax["symbol"] = { common.color "#b6beca" }
style.syntax["comment"] = { common.color "#485263" }
style.syntax["keyword"] = { common.color "#c68aee" }  -- local function end, if case
style.syntax["keyword2"] = { common.color "#c68aee" } -- self, int float
style.syntax["number"] = { common.color "#e05f65" }
style.syntax["literal"] = { common.color "#b6beca" }
style.syntax["string"] = { common.color "#78dba9" }
style.syntax["operator"] = { common.color "#74bee9"}  -- = + - / < >
style.syntax["function"] = { common.color "#70a5eb" }

-- PLUGINS
style.linter_warning = { common.color "#f1cf8a" }     -- linter
style.bracketmatch_color = { common.color "#4d5768" } -- bracketmatch
style.guide = { common.color "#1a1e23" }
style.guide_highlight = { common.color "#242931" }              -- indentguide
style.guide_width = 1                                 -- indentguide
