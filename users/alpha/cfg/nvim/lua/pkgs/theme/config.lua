local M = {}

M.highlights_base = function (colors, opts)
  return {
    Normal = { fg = colors.foreground, bg = colors.background },
    StatusLine = { bg = colors.statusline_bg, fg = colors.foreground },
    StatusLineNC = { bg = colors.statusline_bg, fg = colors.white }, -- note that if `StatusLineNC` is equal to `StatusLine`, nvim will use '^' in the status-line of the current window
    SignColumn = { bg = colors.background, fg = colors.background },
    MsgArea = { fg = colors.foreground, bg = colors.background },
    ModeMsg = { fg = colors.foreground, bg = colors.background },
    MsgSeparator = { fg = colors.foreground, bg = colors.background },
    SpellBad = { fg = colors.green },
    SpellCap = { fg = colors.cyan },
    SpellLocal = { fg = colors.blue },
    SpellRare = { fg = colors.cyan },
    NormalNC = { fg = colors.foreground, bg = colors.background },
    WildMenu = { fg = colors.white, bg = colors.blue },
    CursorLineNr = { fg = colors.foreground },
    Comment = { fg = colors.comments, italic = opts.italics.comments },
    Folded = { fg = colors.blue, bg = colors.background },
    FoldColumn = { fg = colors.blue, bg = colors.background },
    LineNr = { fg = colors.brightblack, bg = colors.background },
    FloatBorder = { fg = colors.background, bg = colors.background },
    Whitespace = { fg = colors.red },
    VertSplit = { bg = colors.background, fg = colors.black },
    CursorLine = { bg = colors.cursorline },
    CursorColumn = { bg = colors.background },
    ColorColumn = { bg = colors.background },
    NormalFloat = { bg = colors.background },
    Visual = { bg = colors.black, fg = colors.foreground },
    VisualNOS = { bg = colors.background },
    WarningMsg = { fg = colors.yellow, bg = colors.background },
    DiffAdd = { bg = colors.background, fg = colors.green },
    DiffChange = { bg = colors.background, fg = colors.blue },
    DiffDelete = { bg = colors.background, fg = colors.red },
    QuickFixLine = { bg = colors.green },
    MatchParen = { fg = colors.blue, bg = colors.background },
    Cursor = { fg = colors.fomeground, bg = colors.cursor },
    lCursor = { fg = colors.foreground, bg = colors.cursor },
    CursorIM = { fg = colors.foreground, bg = colors.cursor },
    TermCursor = { fg = colors.foreground, bg = colors.cursor },
    TermCursorNC = { fg = colors.foreground, bg = colors.cursor },
    Conceal = { fg = colors.blue, bg = colors.background },
    Directory = { fg = colors.blue },
    SpecialKey = { fg = colors.blue },
    Title = { fg = colors.blue },
    ErrorMsg = { fg = colors.red, bg = colors.background },
    Search = { fg = colors.background, bg = colors.brightgreen },
    IncSearch = { fg = colors.background, bg = colors.brightgreen },
    Substitute = { fg = colors.yellow, bg = colors.cyan },
    MoreMsg = { fg = colors.magenta },
    Question = { fg = colors.magenta },
    EndOfBuffer = { fg = colors.background },
    NonText = { fg = colors.red },
    Variable = { fg = colors.magenta },
    String = { fg = colors.green },
    Character = { fg = colors.brightblue },
    Constant = { fg = colors.magenta },
    Number = { fg = colors.red },
    Boolean = { fg = colors.magenta },
    Float = { fg = colors.magenta },
    Identifier = { fg = colors.magenta },
    Function = { fg = colors.blue },
    Operator = { fg = colors.cyan },
    Type = { fg = colors.magenta },
    StorageClass = { fg = colors.magenta },
    Structure = { fg = colors.cyan },
    Typedef = { fg = colors.cyan },
    Keyword = { fg = colors.magenta, italic = opts.italics.code },
    Statement = { fg = colors.cyan },
    Conditional = { fg = colors.magenta },
    Repeat = { fg = colors.magenta, italic = opts.italics.code },
    Label = { fg = colors.red },
    Exception = { fg = colors.brightred },
    Include = { fg = colors.magenta },
    PreProc = { fg = colors.blue },
    Define = { fg = colors.blue },
    Macro = { fg = colors.cyan },
    PreCondit = { fg = colors.cyan },
    Special = { fg = colors.cyan },
    SpecialChar = { fg = colors.foreground },
    Tag = { fg = colors.blue },
    Debug = { fg = colors.red },
    Delimiter = { fg = colors.foreground },
    SpecialComment = { fg = colors.comments },
    Ignore = { fg = colors.white, bg = colors.background },
    Todo = { fg = colors.red, bg = colors.background },
    Error = { fg = colors.red, bg = colors.background },
    TabLine = { fg = colors.green, bg = colors.contrast },
    TabLineSel = { fg = colors.foreground, bg = colors.background },
    TabLineFill = { fg = colors.foreground, bg = colors.background },

    -- Treesitter
    ["@comment"] = { fg = colors.comments },
    ["@error"] = { fg = colors.red },
    ["@preproc"] = { fg = colors.magenta }, -- various preprocessor directives & shebangs
    ["@define"] = { fg = colors.magenta }, -- preprocessor definition directives
    ["@operator"] = { fg = colors.cyan }, -- For any operator: +, but also -> and * in cp.

    -- Punctuation
    ["@punctuation.delimiter"] = { fg = colors.cyan }, -- For delimiters ie: .
    ["@punctuation.bracket"] = { fg = colors.cyan }, -- For brackets and parenthesis.
    ["@punctuation.special"] = { fg = colors.cyan }, -- For special punctutation that does not fall in the catagories before.

    -- Literals
    ["@string"] = { fg = colors.green }, -- For strings.
    ["@string.regex"] = { fg = colors.yellow }, -- For regexes.
    ["@string.escape"] = { fg = colors.yellow }, -- For escape characters within a string.
    ["@string.special"] = { fg = colors.green }, -- other special strings (e.g. dates)

    ["@character"] = { fg = colors.blue }, -- character literals
    ["@character.special"] = { fg = colors.blue }, -- special characters (e.g. wildcards)

    ["@boolean"] = { fg = colors.magenta }, -- For booleans.
    ["@number"] = { fg = colors.red }, -- For all numbers
    ["@float"] = { fg = colors.red }, -- For floats.

    -- Functions
    ["@function"] = { fg = colors.blue }, -- For function (calls and definitions).
    ["@function.builtin"] = { fg = colors.blue }, -- For builtin functions: table.insert in Lua.
    ["@function.call"] = { fg = colors.blue }, -- function calls
    ["@function.macro"] = { fg = colors.cyan }, -- For macro defined functions (calls and definitions): each macro_rules in Ruscp.
    ["@method"] = { fg = colors.blue }, -- For method calls and definitions.

    ["@method.call"] = { fg = colors.blue }, -- method calls

    ["@constructor"] = { fg = colors.yellow }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.
    ["@parameter"] = { fg = colors.cyan }, -- For parameters of a function.

    -- Keywords
    ["@keyword"] = { fg = colors.magenta, italic = opts.italics.code }, -- For keywords that don't fall in previous categories.
    ["@keyword.function"] = { fg = colors.magenta, italic = opts.italics.code }, -- For keywords used to define a fuction.
    ["@keyword.operator"] = { fg = colors.magenta }, -- For new keyword operator
    ["@keyword.return"] = { fg = colors.magenta, italic = opts.italics.code },

    ["@conditional"] = { fg = colors.magenta, italic = opts.italics.code }, -- For keywords related to conditionnals.
    ["@repeat"] = { fg = colors.magenta, italic = opts.italics.code }, -- For keywords related to loops.
    -- @debug            ; keywords related to debugging
    ["@label"] = { fg = colors.magenta }, -- For labels: label: in C and :label: in Lua.
    ["@include"] = { fg = colors.magenta, italic = opts.italics.code }, -- For includes: #include in C, use or extern crate in Rust, or require in Lua.
    ["@exception"] = { fg = colors.red, italic = opts.italics.code }, -- For exception related keywords.

    -- Types

    ["@type"] = { fg = colors.yellow }, -- For types.
    ["@type.builtin"] = { fg = colors.yellow }, -- For builtin types.
    ["@type.definition"] = { fg = colors.cyan }, -- type definitions (e.g. `typedef` in C)
    ["@type.qualifier"] = { fg = colors.magenta }, -- type qualifiers (e.g. `const`)

    ["@storageclass"] = { fg = colors.yellow }, -- visibility/life-time/etc. modifiers (e.g. `static`)
    ["@attribute"] = { fg = colors.blue }, -- attribute annotations (e.g. Python decorators)
    ["@field"] = { fg = colors.cyan }, -- For fields.
    ["@property"] = { fg = colors.cyan }, -- Same as TSField.

    -- Identifiers

    ["@variable"] = { fg = colors.foreground }, -- Any variable name that does not have another highlighcp.
    ["@variable.builtin"] = { fg = colors.yellow }, -- Variable names that are defined by the languages, like this or self.

    ["@constant"] = { fg = colors.yellow }, -- For constants
    ["@constant.builtin"] = { fg = colors.yellow }, -- For constant that are built in the language: nil in Lua.
    ["@constant.macro"] = { fg = colors.red }, -- For constants that are defined by macros: NULL in cp.

    ["@namespace"] = { fg = colors.magenta }, -- For identifiers referring to modules and namespaces.
    ["@symbol"] = { fg = colors.magenta },

    -- Text

    ["@text"] = { fg = colors.foreground }, -- For strings considerated text in a markup language.
    ["@text.strong"] = { fg = colors.foreground }, -- italic
    ["@text.emphasis"] = { fg = colors.cyan },
    ["@text.underline"] = { sp = colors.foreground, undercurl = true }, -- underlined text
    ["@text.strike"] = { fg = colors.foreground }, -- strikethrough text
    ["@text.title"] = { fg = colors.blue }, -- titles like: # Example
    ["@text.literal"] = { fg = colors.cyan },
    ["@text.uri"] = { fg = colors.cyan, undercurl = true }, -- urls, links and emails
    ["@text.math"] = { fg = colors.blue }, -- math environments (e.g. `$ ... $` in LaTeX)
    ["@text.environment"] = { fg = colors.magenta }, -- text environments of markup languages
    ["@text.environment.name"] = { fg = colors.blue }, -- text indicating the type of an environment
    ["@text.reference"] = { fg = colors.magenta }, -- references

    ["@text.todo"] = { bg = colors.yellow }, -- todo notes
    ["@text.note"] = { fg = colors.background, bg = colors.magenta },
    ["@text.warning"] = { fg = colors.background, bg = colors.yellow },
    ["@text.danger"] = { fg = colors.background, bg = colors.red },

    ["@text.diff.add"] = { fg = colors.green }, -- added text (for diff files)
    ["@text.diff.delete"] = { fg = colors.red }, -- deleted text (for diff files)

    -- Tags
    ["@tag"] = { fg = colors.red }, -- Tags like html tag names.
    ["@tag.attribute"] = { fg = colors.blue }, -- Tags like html tag names.
    ["@tag.delimiter"] = { fg = colors.foreground }, -- Tag delimiter like < > /

    -- Language specific:

    -- toml
    ["@property.toml"] = { fg = colors.blue }, -- Differentiates between string and properties

    -- json
    ["@label.json"] = { fg = colors.blue }, -- For labels: label: in C and :label: in Lua.

    -- lua
    ["@field.lua"] = { fg = colors.cyan },
    ["@constructor.lua"] = { fg = colors.blue }, -- For constructor calls and definitions: = { } in Lua, and Java constructors.

    -- typescript
    ["@constructor.typescript"] = { fg = colors.yellow },

    -- TSX (Typescript React)
    ["@keyword.export"] = { fg = colors.magenta },
    ["@constructor.tsx"] = { fg = colors.yellow },
    ["@tag.attribute.tsx"] = { fg = colors.magenta },

    -- cpp
    ["@property.cpp"] = { fg = colors.magenta },

    -- yaml
    ["@field.yaml"] = { fg = colors.blue }, -- For fields.

    -- Ruby
    ["@symbol.ruby"] = { fg = colors.red },

    -- LspTrouble
    LspTroubleText = { fg = colors.foreground },
    LspTroubleCount = { fg = colors.cyan, bg = colors.foreground },
    LspTroubleNormal = { fg = colors.foreground, bg = colors.background },

    -- Illuminate
    illuminatedWord = { bg = colors.foreground },
    illuminatedCurWord = { bg = colors.foreground },

    -- diff
    diffAdded = { fg = colors.blue },
    diffRemoved = { fg = colors.red },
    diffChanged = { fg = colors.magenta },
    diffOldFile = { fg = colors.magenta },
    diffNewFile = { fg = colors.magenta },
    diffFile = { fg = colors.white },
    diffLine = { fg = colors.red },
    diffIndexLine = { fg = colors.cyan },

   -- Neogit
    NeogitBranch = { fg = colors.cyan },
    NeogitRemote = { fg = colors.cyan },
    NeogitHunkHeader = { bg = colors.background, fg = colors.foreground },
    NeogitHunkHeaderHighlight = { bg = colors.foreground, fg = colors.white },
    NeogitDiffContextHighlight = { bg = colors.background, fg = colors.foreground },
    NeogitDiffDeleteHighlight = { fg = colors.red, bg = colors.red },
    NeogitDiffAddHighlight = { fg = colors.blue, bg = colors.blue },

    -- GitGutter
    GitGutterAdd = { fg = colors.blue }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = colors.magenta }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { fg = colors.red }, -- diff mode: Deleted line |diff.txt|

    -- GitSigns
    GitSignsAdd = { fg = colors.blue }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = colors.magenta }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = colors.red }, -- diff mode: Deleted line |diff.txt|

    -- Telescope
    TelescopeBorder = { fg = colors.black, bg = colors.background },
    TelescopeNormal = { fg = colors.foreground, bg = colors.background },
    TelescopeSelection = { fg = colors.foreground, bg = colors.brightblack },

    -- Indent Blank Line
    IndentBlanklineChar = { fg = colors.black, bg = 'NONE' },
    IndentBlanklineContextChar = { fg = colors.comments, bg = 'NONE' },
    IndentBlanklineContextStart = { sp = colors.comments, underline = true, bg = 'NONE' },

    -- NvimTree
    NvimTreeNormal = { fg = colors.foreground, bg = colors.background },
    NvimTreeNormalNC = { fg = colors.foreground, bg = colors.background },
    NvimTreeRootFolder = { fg = colors.red },
    NvimTreeGitDirty = { fg = colors.magenta },
    NvimTreeGitNew = { fg = colors.blue },
    NvimTreeGitDeleted = { fg = colors.red },
    NvimTreeSpecialFile = { fg = colors.cyan },
    NvimTreeIndentMarker = { fg = colors.black },
    NvimTreeImageFile = { fg = colors.foreground },
    NvimTreeSymlink = { fg = colors.white },
    NvimTreeFolderIcon = { fg = colors.blue },
    NvimTreeFolderName = { fg = colors.foreground },
    NvimTreeOpenedFolderName = { fg = colors.blue },
    NvimTreeEmptyFolderName = { fg = colors.green },
    NvimTreeStatusLineNC = { bg = colors.background, fg = colors.background },

    -- LspSaga
		LspSagaCodeActionTitle = { fg = colors.accent },
		LspSagaCodeActionBorder = { fg = colors.lighter },
		LspSagaCodeActionTrunCateLine = { fg = colors.lighter },
		LspSagaCodeActionContent = { fg = colors.foreground },
		-- finder
		LspSagaLspFinderBorder = { fg = colors.lighter },
		LspSagaAutoPreview = { fg = colors.lighter },
		LspSagaFinderSelection = { fg = colors.cursorline },
		TargetFileName = { fg = colors.accent },
		FinderParam = { fg = colors.cyan },
		FinderVirtText = { fg = colors.magenta },
		DefinitionsIcon = { fg = colors.blue },
		Definitions = { fg = colors.blue },
		DefinitionCount = { fg = colors.coolor4 },
		ReferencesIcon = { fg = colors.yellow },
		References = { fg = colors.green },
		ReferencesCount = { fg = colors.green },
		ImplementsIcon = { fg = colors.magenta },
		Implements = { fg = colors.magenta },
		ImplementsCount = { fg = colors.magenta },
		--finder spinner
		FinderSpinnerBorder = { fg = colors.lighter },
		FinderSpinnerTitle = { fg = colors.accent },
		FinderSpinner = { fg = colors.accent },
		FinderPreviewSearch = { fg = colors.green },
		-- definition
		DefinitionBorder = { fg = colors.lighter },
		DefinitionArrow = { fg = colors.accent },
		DefinitionSearch = { fg = colors.green },
		DefinitionFile = { fg = colors.accent },
		-- hover
		LspSagaHoverBorder = { fg = colors.lighter },
		LspSagaHoverTrunCateLine = { fg = colors.lighter },
		-- rename
		LspSagaRenameBorder = { fg = colors.lighter },
		LspSagaRenameMatch = { fg = colors.black },
		-- diagnostic
		LspSagaDiagnosticSource = { link = 'Comment' },
		LspSagaDiagnosticError = { link = 'DiagnosticError' },
		LspSagaDiagnosticWarn = { link = 'DiagnosticWarn' },
		LspSagaDiagnosticInfo = { link = 'DiagnosticInfo' },
		LspSagaDiagnosticHint = { link = 'DiagnosticHint' },
		LspSagaErrorTrunCateLine = { link = 'DiagnosticError' },
		LspSagaWarnTrunCateLine = { link = 'DiagnosticWarn' },
		LspSagaInfoTrunCateLine = { link = 'DiagnosticInfo' },
		LspSagaHintTrunCateLine = { link = 'DiagnosticHint' },
		LspSagaDiagnosticBorder = { fg = colors.lighter },
		LspSagaDiagnosticHeader = { fg = colors.accent },
		DiagnosticQuickFix = { fg = colors.accent },
		DiagnosticMap = { fg = colors.magenta },
		DiagnosticLineCol = { fg = colors.black },
		LspSagaDiagnosticTruncateLine = { link = 'LspSagaDiagnosticBorder' },
		ColInLineDiagnostic = { link = 'Comment' },
		-- signture help
		LspSagaSignatureHelpBorder = { fg = colors.lighter },
		LspSagaShTrunCateLine = { link = 'LspSagaSignatureHelpBorder' },
		-- lightbulb
		LspSagaLightBulb = { link = 'DiagnosticSignHint' },
		-- shadow
		SagaShadow = { fg = 'black' },
		-- float
		LspSagaBorderTitle = { link = 'String' },
		-- Outline
		LSOutlinePreviewBorder = { fg = colors.lighter },
		OutlineIndentEvn = { fg = colors.magenta },
		OutlineIndentOdd = { fg = colors.yellow },
		OutlineFoldPrefix = { fg = colors.accent },
		OutlineDetail = { fg = colors.black },
		-- all floatwindow of lspsaga
		LspFloatWinNormal = { link = 'Normal' },

    -- NeoVim
    healthError = { fg = colors.red },
    healthSuccess = { fg = colors.blue },
    healthWarning = { fg = colors.magenta },

    -- BufferLine
    BufferLineIndicatorSelected = { bg = colors.blue, fg = colors.background },
    BufferLineBufferSelected = { bg = colors.blue, fg = colors.background },
    BufferLineCloseButtonSelected = { bg = colors.blue, fg = colors.background },
    BufferLineModifiedSelected = { bg = colors.blue, fg = colors.background },
    BufferLineHintSelected = { bg = colors.blue, fg = colors.background },
    BufferLineInfoDiagnosticSelected = { bg = colors.blue, fg = colors.background },
    BufferLineIndicatorDiagnosticSelected = { bg = colors.blue, fg = colors.background },
    BufferLineDiagnosticSelected = { bg = colors.blue, fg = colors.background },
    BufferLineDuplicateSelected = { bg = colors.blue, fg = colors.background },
    BufferLineOffsetSeparator = { bg = colors.background, fg = colors.background },
    BufferLineFill = { fg = colors.foreground, bg = colors.contrast },
    BufferLineGroupLabel = { fg = colors.background, bg = colors.accent },
    BufferLineGroupSeparator = { fg = colors.background, bg = colors.background },

    BufferLineSeparator = { fg = colors.background, bg = colors.background },
    BufferLineSeparatorVisible = { fg = colors.background, bg = colors.background },
    BufferLineSeparatorSelected = { fg = colors.background, bg = colors.background },

    -- Barbar
    BufferCurrentSign = { fg = colors.blue },
    BufferInactiveSign = { fg = colors.background, bg = colors.background },
    BufferOffset = { fg = colors.background, bg = colors.background },
    BufferTabpageFill = { fg = colors.background, bg = colors.background },

    -- Diagnostics support
    DiagnosticError = { fg = colors.red }, -- red
    DiagnosticWarn = { fg = colors.yellow }, -- yellow
    DiagnosticInfo = { fg = colors.blue }, -- blue
    DiagnosticHint = { fg = colors.cyan }, -- cyan

    -- Underline
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red }, -- red
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow }, -- yellow
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.blue }, -- blue
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan }, -- cyan
  }
end

return M
