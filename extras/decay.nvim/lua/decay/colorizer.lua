local utbl = require "decay.utils.table"
local ucolor = require "decay.utils.color"
local Ts = require "decay.treesitter"

local colorizer = { mt = {}, _private = {} }
local vim = vim
local setmetatable = setmetatable

function colorizer:highlights(c)
  local options = self._private.config

  return {
    Foo = { bg = c.magenta, fg = c.foreground },
    Comment = { fg = c.black_1, style = options.styles.comments },
    ColorColumn = { bg = c.black },
    Conceal = { fg = c.black_2 },
    Cursor = { fg = c.background, bg = c.foreground },
    lCursor = { fg = c.background, bg = c.foreground },
    CursorIM = { fg = c.background, bg = c.foreground },
    CursorColumn = { bg = c.background_1 },
    CursorLine = { bg = c.background_1 },
    Directory = { fg = c.blue },
    DiffAdd = { bg = c.diff.add },
    DiffChange = { bg = c.diff.change },
    DiffDelete = { bg = c.diff.delete },
    DiffText = { bg = c.diff.text },
    EndOfBuffer = { fg = c.background },
    ErrorMsg = { fg = c.red },
    VertSplit = { fg = c.black_1 },
    WinSeparator = { fg = c.black_1, bold = true },
    Folded = { fg = c.blue, bg = c.black },
    FoldColumn = { bg = options.transparent and "NONE" or c.background, fg = c.black_1 },
    SignColumn = { bg = options.transparent and "NONE" or c.background, fg = c.black },
    SignColumnSB = { bg = c.background_0, fg = c.black },
    Substitute = { bg = c.red, fg = c.black },
    LineNr = { fg = c.black },
    CursorLineNr = { fg = c.black_2 },
    MatchParen = { fg = c.orange, bold = true },
    ModeMsg = { fg = c.light_white, bold = true },
    MsgArea = { fg = c.light_white },
    MoreMsg = { fg = c.blue },
    NonText = { fg = c.background_3 },
    Normal = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    NormalNC = { fg = c.foreground, bg = options.transparent and "NONE" or options.dim_inactive and c.background_0 or c.background },
    NormalSB = { fg = c.foreground, bg = c.background_0 },
    NormalFloat = { fg = c.foreground, bg = c.background },
    FloatBorder = { fg = c.accent, bg = c.background },
    FloatTitle = { fg = c.accent, bg = c.background },
    Pmenu = { bg = c.background_2, fg = c.foreground },
    PmenuSel = { bg = ucolor.darken(c.black, 0.8) },
    PmenuSbar = { bg = ucolor.lighten(c.background_2, 0.95) },
    PmenuThumb = { bg = c.black },
    Question = { fg = c.blue },
    QuickFixLine = { bg = c.black_1, bold = true },
    Search = { bg = ucolor.darken(c.blue, 30), fg = c.background },
    IncSearch = { bg = c.accent, fg = c.background },
    CurSearch = { link = "IncSearch" },
    SpecialKey = { fg = c.background_3 },
    SpellBad = { sp = c.red, undercurl = true },
    SpellCap = { sp = c.yellow, undercurl = true },
    SpellLocal = { sp = c.cyan, undercurl = true },
    SpellRare = { sp = c.aqua, undercurl = true },
    StatusLine = { fg = c.foreground, bg = c.background_2 },
    StatusLineNC = { fg = c.black, bg = c.background_2 },
    TabLine = { bg = c.background_2, fg = c.black },
    TabLineFill = { bg = c.black },
    TabLineSel = { fg = c.black, bg = c.blue },
    Title = { fg = c.blue, bold = true },
    Visual = { bg = c.black_1 },
    VisualNOS = { bg = c.black_1 },
    WarningMsg = { fg = c.yellow },
    Whitespace = { fg = c.black },
    WildMenu = { bg = c.black_1 },
    Constant = { fg = c.orange },
    Number = { fg = c.red },
    String = { fg = c.green },
    Character = { fg = c.green },
    Identifier = { fg = c.magenta, style = options.styles.variables },
    Function = { fg = c.blue, style = options.styles.functions },
    Statement = { fg = c.magenta },
    Operator = { fg = c.blue },
    Keyword = { fg = c.cyan, style = options.styles.keywords },
    PreProc = { fg = c.cyan },
    Special = { fg = c.blue },
    SpecialChar = { fg = c.foreground },
    Debug = { fg = c.orange },
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Error = { fg = c.red },
    Todo = { bg = c.yellow, fg = c.background },
    qfLineNr = { fg = c.black_2 },
    qfFileName = { fg = c.blue },
    htmlH1 = { fg = c.magenta, bold = true },
    htmlH2 = { fg = c.blue, bold = true },
    mkdCodeDelimiter = { bg = c.terminal_black, fg = c.foreground },
    mkdCodeStart = { fg = c.aqua, bold = true },
    mkdCodeEnd = { fg = c.aqua, bold = true },
    markdownHeadingDelimiter = { fg = c.orange, bold = true },
    markdownCode = { fg = c.aqua },
    markdownCodeBlock = { fg = c.aqua },
    markdownH1 = { fg = c.magenta, bold = true },
    markdownH2 = { fg = c.blue, bold = true },
    markdownLinkText = { fg = c.blue, underline = true },
    ["helpCommand"] = { bg = c.terminal_black, fg = c.blue },
    debugPC = { bg = c.background_0 },
    debugBreakpoint = { bg = ucolor.darken(c.cyan, 0.1), fg = c.cyan },
    dosIniLabel = { link = "@property" },
    LspReferenceText = { bg = c.black },
    LspReferenceRead = { bg = c.black },
    LspReferenceWrite = { bg = c.black },
    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.yellow },
    DiagnosticInfo = { fg = c.cyan },
    DiagnosticHint = { fg = c.aqua },
    DiagnosticUnnecessary = { fg = c.terminal_black },
    DiagnosticVirtualTextError = { bg = ucolor.darken(c.red, 0.1), fg = c.red },
    DiagnosticVirtualTextWarn = { bg = ucolor.darken(c.yellow, 0.1), fg = c.yellow },
    DiagnosticVirtualTextInfo = { bg = ucolor.darken(c.cyan, 0.1), fg = c.cyan },
    DiagnosticVirtualTextHint = { bg = ucolor.darken(c.aqua, 0.1), fg = c.aqua },
    DiagnosticUnderlineError = { undercurl = true, sp = c.red },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.yellow },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.cyan },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.aqua },
    LspSignatureActiveParameter = { bg = ucolor.darken(c.black_1, 0.4), bold = true },
    LspCodeLens = { fg = c.black_1 },
    LspInlayHint = { bg = ucolor.darken(c.blue, 0.1), fg = c.background_3 },
    LspInfoBorder = { fg = c.accent, bg = c.accent },
    ALEErrorSign = { fg = c.red },
    ALEWarningSign = { fg = c.yellow },
    DapStoppedLine = { bg = ucolor.darken(c.yellow, 0.1) },
    ["@operator"] = { fg = c.orange },
    ["@punctuation.delimiter"] = { fg = ucolor.lighten(c.cyan, 60) },
    ["@punctuation.bracket"] = { fg = c.white },
    ["@punctuation.special"] = { fg = c.yellow },
    ["@punctuation.special.markdown"] = { fg = c.orange, bold = true },
    ["@string.documentation"] = { fg = c.yellow },
    ["@string.regex"] = { fg = c.blue6 },
    ["@string.escape"] = { fg = c.magenta },
    ["@constructor"] = { fg = c.magenta },
    ["@parameter"] = { fg = c.yellow },
    ["@parameter.builtin"] = { fg = ucolor.lighten(c.yellow, 0.8) },
    ["@keyword"] = { fg = c.purple, style = options.styles.keywords },
    ["@keyword.function"] = { fg = c.magenta, style = options.styles.functions },
    ["@label"] = { fg = c.blue },
    ["@type.builtin"] = { fg = ucolor.darken(c.blue, 0.8) },
    ["@field"] = { fg = c.cyan },
    ["@property"] = { fg = c.blue },
    ["@variable"] = { fg = c.foreground, style = options.styles.variables },
    ["@variable.builtin"] = { fg = c.red },
    ["@namespace.builtin"] = { fg = c.red },
    ["@text.literal.markdown_inline"] = { bg = c.terminal_black, fg = c.blue },
    ["@text.reference"] = { fg = c.aqua },
    ["@text.todo.unchecked"] = { fg = c.blue },
    ["@text.todo.checked"] = { fg = c.green },
    ["@text.warning"] = { fg = c.background, bg = c.yellow },
    ["@text.danger"] = { fg = c.background, bg = c.red },
    ["@text.diff.add"] = { link = "DiffAdd" },
    ["@text.diff.delete"] = { link = "DiffDelete" },
    ["@namespace"] = { link = "Include" },
    ["@tag.tsx"] = { fg = c.red },
    ["@constructor.tsx"] = { fg = c.blue },
    ["@tag.delimiter.tsx"] = { fg = ucolor.darken(c.blue, 0.7) },
    ["@lsp.type.boolean"] = { link = "@boolean" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.deriveHelper"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
    ["@lsp.type.generic"] = { link = "@variable" },
    ["@lsp.type.interface"] = { fg = ucolor.lighten(c.blue, 0.7) },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { link = "@storageclass" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = c.red },
    ["@lsp.type.variable"] = {},
    ["@lsp.typemod.class.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enum.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.enumMember.defaultLibrary"] = { link = "@constant.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    ["@lsp.typemod.keyword.injected"] = { link = "@keyword" },
    ["@lsp.typemod.macro.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    ["@lsp.typemod.string.injected"] = { link = "@string" },
    ["@lsp.typemod.struct.defaultLibrary"] = { link = "@type.builtin" },
    ["@lsp.typemod.type.defaultLibrary"] = { fg = ucolor.darken(c.blue, 0.8) },
    ["@lsp.typemod.typeAlias.defaultLibrary"] = { fg = ucolor.darken(c.blue, 0.8) },
    ["@lsp.typemod.variable.callable"] = { link = "@function" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.injected"] = { link = "@variable" },
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    rainbowcol1 = { fg = c.red },
    rainbowcol2 = { fg = c.yellow },
    rainbowcol3 = { fg = c.green },
    rainbowcol4 = { fg = c.aqua },
    rainbowcol5 = { fg = c.blue },
    rainbowcol6 = { fg = c.magenta },
    rainbowcol7 = { fg = c.purple },
    TSRainbowRed = { fg = c.red },
    TSRainbowOrange = { fg = c.orange },
    TSRainbowYellow = { fg = c.yellow },
    TSRainbowGreen = { fg = c.green },
    TSRainbowBlue = { fg = c.blue },
    TSRainbowViolet = { fg = c.purple },
    TSRainbowCyan = { fg = c.cyan },
    RainbowDelimiterRed = { fg = c.red },
    RainbowDelimiterOrange = { fg = c.orange },
    RainbowDelimiterYellow = { fg = c.yellow },
    RainbowDelimiterGreen = { fg = c.green },
    RainbowDelimiterBlue = { fg = c.blue },
    RainbowDelimiterViolet = { fg = c.purple },
    RainbowDelimiterCyan = { fg = c.cyan },
    TroubleText = { fg = c.light_white },
    TroubleCount = { fg = c.magenta, bg = c.black },
    TroubleNormal = { fg = c.foreground, bg = c.background_0 },
    illuminatedWord = { bg = c.black },
    illuminatedCurWord = { bg = c.black },
    IlluminatedWordText = { bg = c.black },
    IlluminatedWordRead = { bg = c.black },
    IlluminatedWordWrite = { bg = c.black },
    diffAdded = { fg = c.git.add },
    diffRemoved = { fg = c.git.delete },
    diffChanged = { fg = c.git.change },
    diffOldFile = { fg = c.yellow },
    diffNewFile = { fg = c.orange },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.black_1 },
    diffIndexLine = { fg = c.magenta },
    NeogitBranch = { fg = c.magenta },
    NeogitRemote = { fg = c.purple },
    NeogitHunkHeader = { bg = c.background_1, fg = c.foreground },
    NeogitHunkHeaderHighlight = { bg = c.black, fg = c.blue },
    NeogitDiffContextHighlight = { bg = ucolor.darken(c.black, 0.5), fg = c.light_white },
    NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
    NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },
    NeotestPassed = { fg = c.green },
    NeotestRunning = { fg = c.yellow },
    NeotestFailed = { fg = c.red },
    NeotestSkipped = { fg = c.blue },
    NeotestTest = { fg = c.foreground },
    NeotestNamespace = { fg = c.green },
    NeotestFocused = { fg = c.yellow },
    NeotestFile = { fg = c.aqua },
    NeotestDir = { fg = c.blue },
    NeotestBorder = { fg = c.blue },
    NeotestIndent = { fg = c.foreground },
    NeotestExpandMarker = { fg = c.foreground },
    NeotestAdapterName = { fg = c.purple, bold = true },
    NeotestWinSelect = { fg = c.blue },
    NeotestMarked = { fg = c.blue },
    NeotestTarget = { fg = c.blue },
    GitGutterAdd = { fg = c.git_signs.add },
    GitGutterChange = { fg = c.git_signs.change },
    GitGutterDelete = { fg = c.git_signs.delete },
    GitGutterAddLineNr = { fg = c.git_signs.add },
    GitGutterChangeLineNr = { fg = c.git_signs.change },
    GitGutterDeleteLineNr = { fg = c.git_signs.delete },
    GitSignsAdd = { fg = c.git_signs.add },
    GitSignsChange = { fg = c.git_signs.change },
    GitSignsDelete = { fg = c.git_signs.delete },
    TelescopeBorder = { fg = c.accent, bg = c.background },
    TelescopeNormal = { fg = c.foreground, bg = c.background },
    NvimTreeNormal = { fg = c.foreground, bg = c.background_0 },
    NvimTreeWinSeparator = {
      fg = options.styles.sidebars == "transparent" and c.black_1 or c.background_0,
      bg = c.background_0,
    },
    NvimTreeNormalNC = { fg = c.foreground, bg = c.background_0 },
    NvimTreeRootFolder = { fg = c.blue, bold = true },
    NvimTreeGitDirty = { fg = c.git.change },
    NvimTreeGitNew = { fg = c.git.add },
    NvimTreeGitDeleted = { fg = c.git.delete },
    NvimTreeOpenedFile = { bg = c.background_1 },
    NvimTreeSpecialFile = { fg = c.purple, underline = true },
    NvimTreeIndentMarker = { fg = c.black },
    NvimTreeImageFile = { fg = c.foreground },
    NvimTreeSymlink = { fg = c.blue },
    NvimTreeFolderIcon = { bg = "NONE", fg = c.blue },
    NeoTreeNormal = { fg = c.foreground, bg = c.background_0 },
    NeoTreeNormalNC = { fg = c.foreground, bg = c.background_0 },
    NeoTreeDimText = { fg = c.black },
    FernBranchText = { fg = c.blue },
    GlyphPalette1 = { fg = c.red1 },
    GlyphPalette2 = { fg = c.green },
    GlyphPalette3 = { fg = c.yellow },
    GlyphPalette4 = { fg = c.blue },
    GlyphPalette6 = { fg = c.green },
    GlyphPalette7 = { fg = c.foreground },
    GlyphPalette9 = { fg = c.red },
    DashboardShortCut = { fg = c.cyan },
    DashboardHeader = { fg = c.blue },
    DashboardCenter = { fg = c.magenta },
    DashboardFooter = { fg = c.blue },
    DashboardKey = { fg = c.orange },
    DashboardDesc = { fg = c.cyan },
    DashboardIcon = { fg = c.cyan, bold = true },
    AlphaShortcut = { fg = c.orange },
    AlphaHeader = { fg = c.blue },
    AlphaHeaderLabel = { fg = c.orange },
    AlphaFooter = { fg = c.blue },
    AlphaButtons = { fg = c.cyan },
    WhichKey = { fg = c.cyan },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.magenta },
    WhichKeySeperator = { fg = c.black_1 },
    WhichKeySeparator = { fg = c.black_1 },
    WhichKeyFloat = { bg = c.background_0 },
    WhichKeyValue = { fg = c.black_2 },
    DiagnosticWarning = { link = "DiagnosticWarn" },
    DiagnosticInformation = { link = "DiagnosticInfo" },
    LspFloatWinNormal = { bg = c.accent },
    LspFloatWinBorder = { fg = c.accent },
    LspSagaBorderTitle = { fg = c.cyan },
    LspSagaHoverBorder = { fg = c.blue },
    LspSagaRenameBorder = { fg = c.green },
    LspSagaDefPreviewBorder = { fg = c.green },
    LspSagaCodeActionBorder = { fg = c.blue },
    LspSagaFinderSelection = { fg = c.black_1 },
    LspSagaCodeActionTitle = { fg = c.blue },
    LspSagaCodeActionContent = { fg = c.purple },
    LspSagaSignatureHelpBorder = { fg = c.red },
    ReferencesCount = { fg = c.purple },
    DefinitionCount = { fg = c.purple },
    DefinitionIcon = { fg = c.blue },
    ReferencesIcon = { fg = c.blue },
    TargetWord = { fg = c.cyan },
    healthError = { fg = c.red },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.yellow },
    BufferLineIndicatorSelected = { fg = c.git.change },
    BufferCurrent = { bg = c.background, fg = c.foreground },
    BufferCurrentERROR = { bg = c.background, fg = c.red },
    BufferCurrentHINT = { bg = c.background, fg = c.aqua },
    BufferCurrentINFO = { bg = c.background, fg = c.cyan },
    BufferCurrentWARN = { bg = c.background, fg = c.yellow },
    BufferCurrentIndex = { bg = c.background, fg = c.cyan },
    BufferCurrentMod = { bg = c.background, fg = c.yellow },
    BufferCurrentSign = { bg = c.background, fg = c.background },
    BufferCurrentTarget = { bg = c.background, fg = c.red },
    BufferAlternate = { bg = c.black, fg = c.foreground },
    BufferAlternateERROR = { bg = c.black, fg = c.red },
    BufferAlternateHINT = { bg = c.black, fg = c.aqua },
    BufferAlternateIndex = { bg = c.black, fg = c.cyan },
    BufferAlternateINFO = { bg = c.black, fg = c.cyan },
    BufferAlternateMod = { bg = c.black, fg = c.yellow },
    BufferAlternateSign = { bg = c.black, fg = c.cyan },
    BufferAlternateTarget = { bg = c.black, fg = c.red },
    BufferAlternateWARN = { bg = c.black, fg = c.yellow },
    BufferVisible = { bg = c.background_2, fg = c.foreground },
    BufferVisibleERROR = { bg = c.background_2, fg = c.red },
    BufferVisibleHINT = { bg = c.background_2, fg = c.aqua },
    BufferVisibleINFO = { bg = c.background_2, fg = c.cyan },
    BufferVisibleWARN = { bg = c.background_2, fg = c.yellow },
    BufferVisibleIndex = { bg = c.background_2, fg = c.cyan },
    BufferVisibleMod = { bg = c.background_2, fg = c.yellow },
    BufferVisibleSign = { bg = c.background_2, fg = c.cyan },
    BufferVisibleTarget = { bg = c.background_2, fg = c.red },
    BufferInactive = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.black_2, 0.8) },
    BufferInactiveERROR = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.red, 0.8) },
    BufferInactiveHINT = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.aqua, 0.8) },
   
    BufferInactiveINFO = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.cyan, 0.8) },
    BufferInactiveWARN = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.yellow, 0.8) },
    BufferInactiveIndex = { bg = ucolor.darken(c.background_1, 0.4), fg = c.black_2 },
    BufferInactiveMod = { bg = ucolor.darken(c.background_1, 0.4), fg = ucolor.darken(c.yellow, 0.8) },
    BufferInactiveSign = { bg = ucolor.darken(c.background_1, 0.4), fg = c.background },
    BufferInactiveTarget = { bg = ucolor.darken(c.background_1, 0.4), fg = c.red },
    BufferOffset = { bg = c.background_2, fg = c.black_2 },
    BufferTabpageFill = { bg = ucolor.darken(c.background_1, 0.8), fg = c.black_2 },
    BufferTabpages = { bg = c.background_2, fg = "NONE" },
    Sneak = { fg = c.background_1, bg = c.magenta },
    SneakScope = { bg = c.black_1 },
    HopNextKey = { fg = c.magenta, bold = true },
    HopNextKey1 = { fg = c.blue, bold = true },
    HopNextKey2 = { fg = ucolor.darken(c.blue, 0.6) },
    HopUnmatched = { fg = c.background_3 },
    TSNodeKey = { fg = c.magenta, bold = true },
    TSNodeUnmatched = { fg = c.background_3 },
    LeapMatch = { bg = c.magenta, fg = c.foreground, bold = true },
    LeapLabelPrimary = { fg = c.magenta, bold = true },
    LeapLabelSecondary = { fg = c.green, bold = true },
    LeapBackdrop = { fg = c.background_3 },
    FlashBackdrop = { fg = c.background_3 },
    FlashLabel = { bg = c.magenta, bold = true, fg = c.foreground },
    LightspeedGreyWash = { fg = c.background_3 },
    LightspeedLabel = { fg = c.magenta, bold = true, underline = true },
    LightspeedLabelDistant = { fg = c.green, bold = true, underline = true },
    LightspeedLabelDistantOverlapped = { fg = c.green, underline = true },
    LightspeedLabelOverlapped = { fg = c.magenta, underline = true },
    LightspeedMaskedChar = { fg = c.orange },
    LightspeedOneCharMatch = { bg = c.magenta, fg = c.foreground, bold = true },
    LightspeedPendingOpArea = { bg = c.magenta, fg = c.foreground },
    LightspeedShortcut = { bg = c.magenta, fg = c.foreground, bold = true, underline = true },
    LightspeedUnlabeledMatch = { fg = c.blue, bold = true },
    CmpDocumentation = { fg = c.foreground, bg = c.accent },
    CmpDocumentationBorder = { fg = c.accent, bg = c.accent },
    CmpGhostText = { fg = c.terminal_black },
    CmpItemAbbr = { fg = c.foreground, bg = "NONE" },
    CmpItemAbbrDeprecated = { fg = c.black, bg = "NONE", strikethrough = true },
    CmpItemAbbrMatch = { fg = c.blue, bg = "NONE" },
    CmpItemAbbrMatchFuzzy = { fg = c.blue, bg = "NONE" },
    CmpItemMenu = { fg = c.black_1, bg = "NONE" },
    CmpItemKindDefault = { fg = c.light_white, bg = "NONE" },
    CmpItemKindCodeium = { fg = c.aqua, bg = "NONE" },
    CmpItemKindCopilot = { fg = c.aqua, bg = "NONE" },
    CmpItemKindTabNine = { fg = c.aqua, bg = "NONE" },
    CodeBlock = { bg = c.background_0 },
    NavicSeparator = { fg = c.foreground, bg = "NONE" },
    NavicText = { fg = c.foreground, bg = "NONE" },
    AerialNormal = { fg = c.foreground, bg = "NONE" },
    AerialGuide = { fg = c.black },
    AerialLine = { link = "LspInlayHint" },
    IndentBlanklineChar = { fg = c.black, nocombine = true },
    IndentBlanklineContextChar = { fg = c.purple, nocombine = true },
    IblIndent = { fg = c.black, nocombine = true },
    IblScope = { fg = c.purple, nocombine = true },
    ScrollbarHandle = { fg = "NONE", bg = c.background_1 },
    ScrollbarSearchHandle = { fg = c.orange, bg = c.background_1 },
    ScrollbarSearch = { fg = c.orange, bg = "NONE" },
    ScrollbarErrorHandle = { fg = c.red, bg = c.background_1 },
    ScrollbarError = { fg = c.red, bg = "NONE" },
    ScrollbarWarnHandle = { fg = c.yellow, bg = c.background_1 },
    ScrollbarWarn = { fg = c.yellow, bg = "NONE" },
    ScrollbarInfoHandle = { fg = c.cyan, bg = c.background_1 },
    ScrollbarInfo = { fg = c.cyan, bg = "NONE" },
    ScrollbarHintHandle = { fg = c.aqua, bg = c.background_1 },
    ScrollbarHint = { fg = c.aqua, bg = "NONE" },
    ScrollbarMiscHandle = { fg = c.purple, bg = c.background_1 },
    ScrollbarMisc = { fg = c.purple, bg = "NONE" },
    YankyPut = { link = "IncSearch" },
    YankyYanked = { link = "IncSearch" },
    LazyProgressDone = { bold = true, fg = c.magenta },
    LazyProgressTodo = { bold = true, fg = c.black },
    NotifyBackground = { fg = c.foreground, bg = c.background },
    NotifyERRORBorder = { fg = ucolor.darken(c.red, 0.3), bg = options.transparent and "NONE" or c.background },
    NotifyWARNBorder = { fg = ucolor.darken(c.yellow, 0.3), bg = options.transparent and "NONE" or c.background },
    NotifyINFOBorder = { fg = ucolor.darken(c.cyan, 0.3), bg = options.transparent and "NONE" or c.background },
    NotifyDEBUGBorder = { fg = ucolor.darken(c.black_1, 0.3), bg = options.transparent and "NONE" or c.background },
    NotifyTRACEBorder = { fg = ucolor.darken(c.purple, 0.3), bg = options.transparent and "NONE" or c.background },
    NotifyERRORIcon = { fg = c.red },
    NotifyWARNIcon = { fg = c.yellow },
    NotifyINFOIcon = { fg = c.cyan },
    NotifyDEBUGIcon = { fg = c.black_1 },
    NotifyTRACEIcon = { fg = c.purple },
    NotifyERRORTitle = { fg = c.red },
    NotifyWARNTitle = { fg = c.yellow },
    NotifyINFOTitle = { fg = c.cyan },
    NotifyDEBUGTitle = { fg = c.black_1 },
    NotifyTRACETitle = { fg = c.purple },
    NotifyERRORBody = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    NotifyWARNBody = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    NotifyINFOBody = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    NotifyDEBUGBody = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    NotifyTRACEBody = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    MiniCompletionActiveParameter = { underline = true },
    MiniCursorword = { bg = c.black },
    MiniCursorwordCurrent = { bg = c.black },
    MiniIndentscopeSymbol = { fg = c.blue, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true },
    MiniJump = { bg = c.magenta, fg = "#ffffff" },
    MiniJump2dSpot = { fg = c.magenta, bold = true, nocombine = true },
    MiniStarterCurrent = { nocombine = true },
    MiniStarterFooter = { fg = c.yellow, italic = true },
    MiniStarterHeader = { fg = c.blue },
    MiniStarterInactive = { fg = c.black_1, style = options.styles.comments },
    MiniStarterItem = { fg = c.foreground, bg = options.transparent and "NONE" or c.background },
    MiniStarterItemBullet = { fg = c.accent },
    MiniStarterItemPrefix = { fg = c.yellow },
    MiniStarterSection = { fg = c.blue },
    MiniStarterQuery = { fg = c.cyan },
    MiniStatuslineDevinfo = { fg = c.light_white, bg = c.background_1 },
    MiniStatuslineFileinfo = { fg = c.light_white, bg = c.background_1 },
    MiniStatuslineFilename = { fg = c.light_white, bg = c.black },
    MiniStatuslineInactive = { fg = c.blue, bg = c.background_2 },
    MiniStatuslineModeCommand = { fg = c.black, bg = c.yellow, bold = true },
    MiniStatuslineModeInsert = { fg = c.black, bg = c.green, bold = true },
    MiniStatuslineModeNormal = { fg = c.black, bg = c.blue, bold = true },
    MiniStatuslineModeOther = { fg = c.black, bg = c.aqua, bold = true },
    MiniStatuslineModeReplace = { fg = c.black, bg = c.red, bold = true },
    MiniStatuslineModeVisual = { fg = c.black, bg = c.magenta, bold = true },
    MiniSurround = { bg = c.orange, fg = c.black },
    MiniTablineCurrent = { fg = c.foreground, bg = c.black },
    MiniTablineFill = { bg = c.black },
    MiniTablineHidden = { fg = c.black_2, bg = c.background_2 },
    MiniTablineModifiedCurrent = { fg = c.yellow, bg = c.black },
    MiniTablineModifiedHidden = { bg = c.background_2, fg = ucolor.darken(c.yellow, 0.7) },
    MiniTablineModifiedVisible = { fg = c.yellow, bg = c.background_2 },
    MiniTablineTabpagesection = { bg = c.background_2, fg = "NONE" },
    MiniTablineVisible = { fg = c.foreground, bg = c.background_2 },
    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.red, bold = true },
    MiniTestPass = { fg = c.green, bold = true },
    MiniTrailspace = { bg = c.red },
    NoiceCompletionItemKindDefault = { fg = c.light_white, bg = "NONE" },
    TreesitterContext = { bg = ucolor.darken(c.black, 0.8) },
    Hlargs = { fg = c.yellow },
  }
end

-- thanks: https://github.com/folke/tokyonight.nvim/blob/f247ee700b569ed43f39320413a13ba9b0aef0db/lua/tokyonight/util.lua#L53C1-L70C4
function colorizer:highlight(group, hl)
  local ts = self._private.ts
  group = ts:get(group)
  if not group then
    return
  end
  if hl.style then
    if type(hl.style) == "table" then
      hl = vim.tbl_extend("force", hl, hl.style)
    elseif hl.style:lower() ~= "none" then
      -- handle old string style definitions
      for s in string.gmatch(hl.style, "([^,]+)") do
        hl[s] = true
      end
    end
    hl.style = nil
  end
  vim.api.nvim_set_hl(0, group, hl)
end

function colorizer:colorize(theme)
  vim.opt.termguicolors = true

  -- regular colors
  for group, hl in pairs(self:highlights(theme.colors)) do
    self:highlight(group, hl)
  end

  local ts = self._private.ts

  if ts:new_style() then
    for group, colors in pairs(ts.defaults) do
      self:highlight(group, colors)
    end
  end
end

local function new(config)
  local ret = utbl({}):merge(colorizer)
  ret._private.config = config
  ret._private.ts = Ts()
  return ret
end

function colorizer.mt:__call(...)
  return new(...)
end

return setmetatable(colorizer, colorizer.mt)
