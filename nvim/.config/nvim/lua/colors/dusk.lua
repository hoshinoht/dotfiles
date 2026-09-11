local M = {}

local palettes = {
  dusk = {
    rosewater = "#FCE4DE",
    flamingo = "#F2BFB4",
    pink = "#F3BDCA",
    mauve = "#C4A2D4",
    red = "#E27878",
    maroon = "#E09898",
    peach = "#DDA05C",
    yellow = "#DEC47C",
    green = "#82C8A0",
    teal = "#6EC4B8",
    sky = "#75D6F6",
    sapphire = "#5CB8E4",
    blue = "#68ACE0",
    lavender = "#B0BCE8",
    text = "#F3F5FC",
    subtext1 = "#D2D5DE",
    subtext0 = "#B2B6C1",
    overlay2 = "#8F939F",
    overlay1 = "#7E828F",
    overlay0 = "#6E7280",
    surface2 = "#60646E",
    surface1 = "#52565F",
    surface0 = "#454850",
    base = "#393C43",
    mantle = "#2F3238",
    crust = "#26282D",
  },
  ["dusk-darker"] = {
    rosewater = "#FFD4E2",
    flamingo = "#FFD0DF",
    pink = "#FFB8D1",
    mauve = "#C4A2D4",
    red = "#FF8F9A",
    maroon = "#FFA3AC",
    peach = "#DDA05C",
    yellow = "#F4DA86",
    green = "#9BE6B5",
    teal = "#78E1D0",
    sky = "#8BD3FF",
    sapphire = "#91ECF1",
    blue = "#7BC1F2",
    lavender = "#B0BCE8",
    text = "#FFFFFF",
    subtext1 = "#E6E9F2",
    subtext0 = "#C6CBD6",
    overlay2 = "#A6ADBB",
    overlay1 = "#858B9C",
    overlay0 = "#697080",
    surface2 = "#52617A",
    surface1 = "#414B5E",
    surface0 = "#333B4B",
    base = "#272D39",
    mantle = "#20242E",
    crust = "#171A22",
  },
}

local function set_highlights(highlights)
  for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

local function link_highlights(groups, target)
  local highlights = {}
  for _, group in ipairs(groups) do
    highlights[group] = { link = target }
  end
  set_highlights(highlights)
end

local function theme(c)
  return {
    -- Core editor UI.
    Normal = { fg = c.text, bg = c.base },
    NormalNC = { fg = c.subtext1, bg = c.base },
    NormalFloat = { fg = c.text, bg = c.mantle },
    FloatBorder = { fg = c.sky, bg = c.mantle },
    FloatTitle = { fg = c.mauve, bg = c.mantle, bold = true },
    ColorColumn = { bg = c.surface0 },
    Cursor = { fg = c.base, bg = c.rosewater },
    CursorIM = { fg = c.base, bg = c.rosewater },
    CursorColumn = { bg = c.surface0 },
    CursorLine = { bg = c.surface0 },
    CursorLineNr = { fg = c.pink, bg = c.surface0, bold = true },
    EndOfBuffer = { fg = c.crust, bg = c.base },
    FoldColumn = { fg = c.overlay1, bg = c.base },
    Folded = { fg = c.overlay2, bg = c.mantle },
    LineNr = { fg = c.overlay1, bg = c.base },
    MatchParen = { fg = c.sky, bg = c.surface1, bold = true },
    SignColumn = { bg = c.base },
    StatusLine = { fg = c.text, bg = c.surface1 },
    StatusLineNC = { fg = c.overlay1, bg = c.mantle },
    TabLine = { fg = c.overlay1, bg = c.mantle },
    TabLineFill = { bg = c.mantle },
    TabLineSel = { fg = c.text, bg = c.surface1, bold = true },
    Title = { fg = c.mauve, bold = true },
    VertSplit = { fg = c.surface1, bg = c.base },
    WinSeparator = { fg = c.surface1, bg = c.base },
    WinBar = { fg = c.subtext1, bg = c.base },
    WinBarNC = { fg = c.overlay1, bg = c.base },

    -- Menus, search, and messages.
    Pmenu = { fg = c.text, bg = c.mantle },
    PmenuBorder = { fg = c.surface2, bg = c.mantle },
    PmenuExtra = { fg = c.overlay2, bg = c.mantle },
    PmenuExtraSel = { fg = c.subtext0, bg = c.surface1 },
    PmenuKind = { fg = c.teal, bg = c.mantle },
    PmenuKindSel = { fg = c.teal, bg = c.surface1 },
    PmenuSbar = { bg = c.surface1 },
    PmenuSel = { fg = c.base, bg = c.sky, bold = true },
    PmenuThumb = { bg = c.overlay1 },
    IncSearch = { fg = c.base, bg = c.peach, bold = true },
    Search = { fg = c.base, bg = c.yellow },
    CurSearch = { fg = c.base, bg = c.rosewater, bold = true },
    Substitute = { fg = c.base, bg = c.pink },
    Visual = { bg = c.surface2 },
    VisualNOS = { bg = c.surface2 },
    Directory = { fg = c.blue, bold = true },
    ErrorMsg = { fg = c.red, bold = true },
    ModeMsg = { fg = c.sky, bold = true },
    MoreMsg = { fg = c.teal, bold = true },
    MsgArea = { fg = c.text, bg = c.base },
    MsgSeparator = { fg = c.surface1, bg = c.base },
    Question = { fg = c.green, bold = true },
    WarningMsg = { fg = c.peach, bold = true },
    WildMenu = { fg = c.base, bg = c.sky },
    NonText = { fg = c.overlay0 },
    SpecialKey = { fg = c.overlay1 },
    Whitespace = { fg = c.overlay0 },
    Conceal = { fg = c.overlay1 },
    StatusColumn = { fg = c.overlay1, bg = c.base },

    -- Syntax and Treesitter fallbacks.
    Comment = { fg = c.overlay2, italic = true },
    Constant = { fg = c.peach },
    String = { fg = c.green },
    Character = { fg = c.green },
    Number = { fg = c.peach },
    Boolean = { fg = c.peach, bold = true },
    Float = { fg = c.peach },
    Identifier = { fg = c.text },
    Function = { fg = c.blue, italic = true },
    Statement = { fg = c.mauve },
    Conditional = { fg = c.mauve },
    Repeat = { fg = c.mauve },
    Label = { fg = c.mauve },
    Operator = { fg = c.teal },
    Keyword = { fg = c.mauve },
    Exception = { fg = c.red },
    PreProc = { fg = c.yellow },
    Include = { fg = c.mauve },
    Define = { fg = c.mauve },
    Macro = { fg = c.yellow },
    Type = { fg = c.yellow, italic = true },
    StorageClass = { fg = c.mauve },
    Structure = { fg = c.yellow, italic = true },
    Typedef = { fg = c.yellow, italic = true },
    Special = { fg = c.pink },
    SpecialChar = { fg = c.pink },
    Tag = { fg = c.blue },
    Delimiter = { fg = c.teal },
    Debug = { fg = c.red },
    Bold = { bold = true },
    Italic = { italic = true },
    Underlined = { fg = c.blue, underline = true },
    Error = { fg = c.red },
    Todo = { fg = c.base, bg = c.yellow, bold = true },

    -- Diff and diagnostics.
    Added = { fg = c.green },
    Changed = { fg = c.peach },
    Removed = { fg = c.red },
    DiffAdd = { fg = c.green, bg = c.surface0 },
    DiffChange = { fg = c.peach, bg = c.surface0 },
    DiffDelete = { fg = c.red, bg = c.surface0 },
    DiffText = { fg = c.sky, bg = c.surface1, bold = true },
    DiagnosticError = { fg = c.red },
    DiagnosticWarn = { fg = c.peach },
    DiagnosticInfo = { fg = c.sky },
    DiagnosticHint = { fg = c.teal },
    DiagnosticOk = { fg = c.green },
    DiagnosticUnderlineError = { sp = c.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.peach, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.sky, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.teal, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.green, undercurl = true },
    LspReferenceText = { bg = c.surface1 },
    LspReferenceRead = { bg = c.surface1 },
    LspReferenceWrite = { bg = c.surface1 },

    -- Git signs and common plugin surfaces.
    GitSignsAdd = { fg = c.green, bg = c.base },
    GitSignsChange = { fg = c.peach, bg = c.base },
    GitSignsDelete = { fg = c.red, bg = c.base },
    GitSignsChangedelete = { fg = c.pink, bg = c.base },
    GitSignsTopdelete = { fg = c.red, bg = c.base },
    GitSignsUntracked = { fg = c.teal, bg = c.base },
    BufferLineFill = { fg = c.overlay1, bg = c.crust },
    BufferLineBackground = { fg = c.overlay1, bg = c.mantle },
    BufferLineBufferSelected = { fg = c.text, bg = c.base, bold = true },
    BufferLineIndicatorSelected = { fg = c.sky, bg = c.base },
    BufferLineModifiedSelected = { fg = c.peach, bg = c.base },
    BufferLineModified = { fg = c.peach, bg = c.mantle },
    LualineNormal = { fg = c.base, bg = c.sky },
    LualineInsert = { fg = c.base, bg = c.green },
    LualineVisual = { fg = c.base, bg = c.mauve },
    LualineReplace = { fg = c.base, bg = c.red },
    LualineCommand = { fg = c.base, bg = c.peach },
    LualineInactive = { fg = c.overlay1, bg = c.mantle },
    NeoTreeNormal = { fg = c.text, bg = c.mantle },
    NeoTreeNormalNC = { fg = c.subtext1, bg = c.mantle },
    NeoTreeDirectoryName = { fg = c.blue },
    NeoTreeDirectoryIcon = { fg = c.sky },
    NeoTreeGitAdded = { fg = c.green },
    NeoTreeGitConflict = { fg = c.red },
    NeoTreeGitDeleted = { fg = c.red },
    NeoTreeGitModified = { fg = c.peach },
    NeoTreeGitUntracked = { fg = c.teal },
    TelescopeNormal = { fg = c.text, bg = c.mantle },
    TelescopeBorder = { fg = c.surface2, bg = c.mantle },
    TelescopePromptNormal = { fg = c.text, bg = c.surface0 },
    TelescopePromptBorder = { fg = c.surface0, bg = c.surface0 },
    TelescopePromptTitle = { fg = c.base, bg = c.pink, bold = true },
    TelescopePreviewTitle = { fg = c.base, bg = c.green, bold = true },
    TelescopeResultsTitle = { fg = c.base, bg = c.sky, bold = true },
    TelescopeSelection = { fg = c.text, bg = c.surface1, bold = true },
    WhichKey = { fg = c.pink },
    WhichKeyGroup = { fg = c.mauve },
    WhichKeyDesc = { fg = c.text },
    WhichKeyFloat = { bg = c.mantle },
    WhichKeySeparator = { fg = c.overlay1 },
    TroubleText = { fg = c.text },
    TroubleCount = { fg = c.mauve, bold = true },
    TroubleNormal = { fg = c.text, bg = c.mantle },
    MasonNormal = { fg = c.text, bg = c.mantle },
    MasonHeader = { fg = c.base, bg = c.mauve, bold = true },
    MasonHighlight = { fg = c.sky },
    NoiceCmdlinePopup = { fg = c.text, bg = c.mantle },
    NoiceCmdlinePopupBorder = { fg = c.sky, bg = c.mantle },
    NoicePopup = { fg = c.text, bg = c.mantle },
    NoicePopupBorder = { fg = c.surface2, bg = c.mantle },
    SnacksNormal = { fg = c.text, bg = c.mantle },
    SnacksBackdrop = { bg = c.crust, blend = 35 },
    SnacksPicker = { fg = c.text, bg = c.mantle },
    SnacksPickerBorder = { fg = c.surface2, bg = c.mantle },
    SnacksPickerTitle = { fg = c.base, bg = c.pink, bold = true },
    BlinkCmpMenu = { fg = c.text, bg = c.mantle },
    BlinkCmpMenuBorder = { fg = c.surface2, bg = c.mantle },
    BlinkCmpMenuSelection = { fg = c.base, bg = c.sky, bold = true },
    MiniStatuslineFilename = { fg = c.subtext1, bg = c.surface1 },
    MiniStatuslineModeNormal = { fg = c.base, bg = c.sky, bold = true },
    MiniStatuslineModeInsert = { fg = c.base, bg = c.green, bold = true },
    MiniStatuslineModeVisual = { fg = c.base, bg = c.mauve, bold = true },
    MiniStatuslineModeReplace = { fg = c.base, bg = c.red, bold = true },
    MiniStatuslineModeCommand = { fg = c.base, bg = c.peach, bold = true },
    MiniIndentscopeSymbol = { fg = c.surface2 },
    IblIndent = { fg = c.surface1 },
    IblScope = { fg = c.lavender },
    FlashBackdrop = { fg = c.overlay1 },
    FlashCurrent = { fg = c.base, bg = c.pink, bold = true },
    FlashMatch = { fg = c.base, bg = c.sky, bold = true },
    FlashLabel = { fg = c.base, bg = c.peach, bold = true },
    TodoFgTODO = { fg = c.sky, bold = true },
    TodoFgFIX = { fg = c.red, bold = true },
    TodoFgFIXME = { fg = c.red, bold = true },
    TodoFgHACK = { fg = c.peach, bold = true },
    TodoFgWARN = { fg = c.yellow, bold = true },
    TodoFgPERF = { fg = c.mauve, bold = true },
    TodoFgNOTE = { fg = c.teal, bold = true },
    TodoFgTEST = { fg = c.green, bold = true },
  }
end

function M.setup(name)
  local c = palettes[name]
  if not c then
    error("unknown Dusk colorscheme: " .. tostring(name))
  end

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = name

  set_highlights(theme(c))
  link_highlights({
    "@comment",
    "@comment.documentation",
    "@lsp.type.comment",
  }, "Comment")
  link_highlights({
    "@constant",
    "@constant.builtin",
    "@lsp.type.enumMember",
    "@number",
    "@number.float",
  }, "Constant")
  link_highlights({ "@string", "@string.documentation", "@lsp.type.string" }, "String")
  link_highlights({ "@character", "@character.special" }, "Character")
  link_highlights({ "@boolean" }, "Boolean")
  link_highlights({ "@function", "@function.call", "@function.method", "@method", "@method.call" }, "Function")
  link_highlights({ "@function.builtin", "@function.macro" }, "Special")
  link_highlights({ "@lsp.type.function", "@lsp.type.method" }, "Function")
  link_highlights({ "@constructor", "@type", "@type.builtin", "@type.definition", "@lsp.type.type" }, "Type")
  link_highlights({ "@lsp.type.class", "@lsp.type.enum", "@lsp.type.interface", "@lsp.type.struct" }, "Type")
  link_highlights({ "@keyword", "@keyword.function", "@keyword.operator", "@keyword.return" }, "Keyword")
  link_highlights({ "@lsp.type.keyword" }, "Keyword")
  link_highlights({ "@conditional", "@repeat" }, "Conditional")
  link_highlights({ "@exception", "@lsp.type.event" }, "Exception")
  link_highlights({ "@operator", "@punctuation.delimiter", "@punctuation.bracket" }, "Operator")
  link_highlights({
    "@variable",
    "@variable.parameter",
    "@property",
    "@field",
    "@lsp.type.variable",
    "@lsp.type.parameter",
    "@lsp.type.property",
  }, "Identifier")
  link_highlights({ "@variable.builtin", "@constant.builtin", "@lsp.type.builtin" }, "Special")
  link_highlights({ "@lsp.type.namespace", "@lsp.type.module" }, "Include")
  link_highlights({ "@lsp.type.decorator" }, "PreProc")
  link_highlights({ "@tag", "@tag.attribute", "@tag.delimiter" }, "Tag")
  link_highlights({ "@markup.heading", "@markup.heading.1", "@markup.heading.2", "@markup.heading.3" }, "Title")
  link_highlights({ "@markup.italic" }, "Italic")
  link_highlights({ "@markup.strong" }, "Bold")
  link_highlights({ "@markup.raw", "@markup.raw.block" }, "String")
  link_highlights({ "@diff.plus", "@diff.delta" }, "Added")
  link_highlights({ "@diff.minus" }, "Removed")
end

return M
