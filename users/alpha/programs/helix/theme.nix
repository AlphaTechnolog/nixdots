let
  colors = import ../../theme/colors.nix {};
in with colors; {
  type = yellow;
  constructor = yellow;
  constant = white;
  "constant.builtin" = yellow;
  "constant.character" = cyan;
  "constant.character.escape" = cyan;
  string = green;
  "string.regexp" = red;
  "string.special" = cyan;
  comment.fg = light-black;
  comment.modifiers = [ "italic" ];
  variable = fg;
  "variable.parameter" = { fg = cyan; modifiers = [ "italic" ]; };
  "variable.builtin" = magenta;
  "variable.other.member" = cyan;
  label = blue;
  punctuation = cyan;
  "punctuation.special" = blue;
  "keyword" = magenta;
  "keyword.control.conditional" = { fg = magenta; modifiers = [ "italic" ]; };
  operator = cyan;
  "function" = blue;
  "function.builtin" = magenta;
  "function.macro" = blue;
  tag = red;
  namespace.fg = cyan;
  namespace.modifiers = [ "italic" ];
  special = blue;
  "markup.heading.marker".fg = magenta;
  "markup.heading.1" = blue;
  "markup.heading.2" = blue;
  "markup.heading.3" = blue;
  "markup.heading.4" = blue;
  "markup.heading.5" = blue;
  "markup.heading.6" = blue;
  "markup.list" = cyan;
  "markup.bold" = { modifiers = [ "bold" ]; };
  "markup.italic" = { modifiers = [ "italic" ]; };
  "markup.link.url" = { fg = blue; modifiers = ["italic"]; };
  "markup.link.text" = blue;
  "markup.raw" = fg;
  "diff.plus" = green;
  "diff.minus" = red;
  "diff.delta" = blue;
  "ui.background" = { inherit fg bg; };
  "ui.linenr".fg = light-black;
  "ui.linenr.selected".fg = white;
  "ui.statusline" = { inherit fg; bg = bg-lighter; };
  "ui.statusline.inactive" = { inherit fg; bg = bg-contrast; };
  "ui.statusline.normal" = { fg = bg; bg = blue; };
  "ui.statusline.insert" = { fg = bg; bg = green; };
  "ui.statusline.select" = { fg = bg; bg = magenta; };
  "ui.popup" = { inherit fg; bg = black; };
  "ui.window".fg = fg;
  "ui.help" = { inherit fg bg; };
  "ui.bufferline" = { fg = light-black; inherit bg; };
  "ui.bufferline.active" = { inherit fg; bg = bg-contrast; };
  "ui.bufferline.background" = { bg = bg-darker; };
  "ui.text" = fg;
  "ui.text.focus" = { inherit bg fg; }; # no focus ._. (personal choice btw)
  "ui.virtual" = light-black;
  "ui.virtual.ruler".bg = dimblack;
  "ui.virtual.indent-guide" = dimblack;
  "ui.selection".bg = dimblack;
  "ui.cursor" = { fg = bg; bg = blue; };
  "ui.cursor.primary" = { fg = bg; bg = blue; };
  "ui.cursor.match" = { fg = bg; bg = blue; };
  "ui.cursorline.primary".bg = bg-contrast;
  "ui.highlight" = { bg = blue; fg = bg; };
  "ui.menu" = { inherit fg; bg = black; };
  "ui.menu.selected" = { inherit fg; bg = dimblack; modifiers = [ "bold" ]; };
  diagnostic.modifiers = [ "underlined" ];
  "diagnostic.error" = red;
  "diagnostic.warn" = yellow;
  "diagnostic.info" = cyan;
  "diagnostic.hint" = blue;
  error = red;
  warning = yellow;
  info = cyan;
  hint = blue;
}
