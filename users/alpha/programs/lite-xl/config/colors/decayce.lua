-- Colors from: https://github.com/enkia/tokyo-night-vscode-theme

local style = require "core.style"
local common = require "core.common"

style.background = { common.color "#0d0f18" }
style.background2 = { common.color "#0b0d16" }
style.background3 = { common.color "#0f111a" }
style.text = { common.color "#a5b6cf" }
style.caret = { common.color "#a5b6cf" }
style.accent = { common.color "#86aaec" } -- Text in autocomplete and command, col(>80) in satusbar
style.dim = { common.color "#2b2d36" } -- Text of nonactive tabs, prefix in log
style.divider = { common.color "#11131c" }
style.selection = { common.color "#0f111a" }
style.line_number = { common.color "#2b2d36" }
style.line_number2 = { common.color "#a5b6cf" } -- Number on line with caret
style.line_highlight = { common.color "#11131c"}
style.scrollbar = { common.color "#11131c" }
style.scrollbar2 = { common.color "#2b2d36" } -- Hovered

style.syntax["normal"] = { common.color "#a5b6cf" }
style.syntax["symbol"] = { common.color "#c0caf5" }
style.syntax["comment"] = { common.color "#2b2d36" }
style.syntax["keyword"] = { common.color "#c296eb" }  -- local function end, if case
style.syntax["keyword2"] = { common.color "#c296eb" } -- self, int float
style.syntax["number"] = { common.color "#dd6777" }
style.syntax["literal"] = { common.color "#a5b6cf" }
style.syntax["string"] = { common.color "#95d3af" }
style.syntax["operator"] = { common.color "#98d3ee"}  -- = + - / < >
style.syntax["function"] = { common.color "#86aaec" }

-- PLUGINS
style.linter_warning = { common.color "#ecd3a0" }     -- linter
style.bracketmatch_color = { common.color "#2b2d36" } -- bracketmatch
style.guide = { common.color "#21232c" }
style.guide_highlight = { common.color "#2b2d36" }              -- indentguide
style.guide_width = 1                                 -- indentguide
