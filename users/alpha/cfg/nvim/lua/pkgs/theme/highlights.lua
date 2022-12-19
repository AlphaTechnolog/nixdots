local M = {}
local config = require('pkgs.theme.config')

function M.hi(...)
    vim.api.nvim_set_hl(0, ...)
end

local hi = M.hi

function M.bulk_hi (highlights)
    for group, properties in pairs(highlights) do
        hi(group, properties)
    end
end

function M.highlight_all(colors, opts)
    if not opts.italics then
        opts.italics = {
            code = true,
            comments = false,
        }
    end

    M.bulk_hi(config.highlights_base(colors, opts))

    local ntree = opts.nvim_tree or { contrast = false }

    if ntree.contrast == true then
        M.bulk_hi {
            NvimTreeVertSplit = { bg = colors.contrast, fg = colors.contrast },
            NvimTreeNormal = { bg = colors.contrast },
            NvimTreeNormalNC = { bg = colors.contrast },
            NvimTreeEndOfBuffer = { bg = colors.contrast, fg = colors.contrast },
            NvimTreeEndOfBufferNC = { bg = colors.contrast, fg = colors.contrast },
        }
    end

    if vim.g.decay_cmp_block_kind == true then
        M.bulk_hi {
            Pmenu = { fg = colors.foreground, bg = colors.contrast },
            PmenuSel = { bg = colors.lighter, fg = "NONE" },

            CmpItemAbbrDeprecated = { fg = colors.comments, bg = "NONE" },
            CmpItemAbbrMatch = { fg = colors.blue, bg = "NONE" },
            CmpItemAbbrMatchFuzzy = { fg = colors.blue, bg = "NONE" },
            CmpItemMenu = { fg = colors.magenta, bg = "NONE" },

            CmpItemKindField = { fg = colors.background, bg = colors.red },
            CmpItemKindProperty = { fg = colors.background, bg = colors.red },
            CmpItemKindEvent = { fg = colors.background, bg = colors.red },

            CmpItemKindText = { fg = colors.background, bg = colors.green },
            CmpItemKindEnum = { fg = colors.background, bg = colors.green },
            CmpItemKindKeyword = { fg = colors.background, bg = colors.green },

            CmpItemKindConstant = { fg = colors.background, bg = colors.yellow },
            CmpItemKindConstructor = { fg = colors.background, bg = colors.yellow },
            CmpItemKindReference = { fg = colors.background, bg = colors.yellow },

            CmpItemKindFunction = { fg = colors.background, bg = colors.magenta },
            CmpItemKindStruct = { fg = colors.background, bg = colors.magenta },
            CmpItemKindClass = { fg = colors.background, bg = colors.magenta },
            CmpItemKindModule = { fg = colors.background, bg = colors.magenta },
            CmpItemKindOperator = { fg = colors.background, bg = colors.magenta },

            CmpItemKindVariable = { fg = colors.black, bg = colors.white },
            CmpItemKindFile = { fg = colors.black, bg = colors.white },

            CmpItemKindUnit = { fg = colors.background, bg = colors.yellow },
            CmpItemKindSnippet = { fg = colors.background, bg = colors.yellow },
            CmpItemKindFolder = { fg = colors.background, bg = colors.yellow },

            CmpItemKindMethod = { fg = colors.background, bg = colors.blue },
            CmpItemKindValue = { fg = colors.background, bg = colors.blue },
            CmpItemKindEnumMember = { fg = colors.background, bg = colors.blue },

            CmpItemKindInterface = { fg = colors.background, bg = colors.brightgreen },
            CmpItemKindColor = { fg = colors.background, bg = colors.brightgreen },
            CmpItemKindTypeParameter = { fg = colors.background, bg = colors.brightgreen },
        }
    else
        M.bulk_hi {
            Pmenu = { fg = colors.foreground, bg = colors.contrast },
            PmenuSel = { fg = colors.contrast, bg = colors.blue },
            CmpDocumentationBorder = { fg = colors.foreground },
            CmpItemAbbr = { fg = colors.foreground },
            CmpItemAbbrDeprecated = { fg = colors.yellow },
            CmpItemAbbrMatch = { fg = colors.blue },
            CmpItemAbbrMatchFuzzy = { fg = colors.blue },
            CmpItemKind = { fg = colors.blue },
            CmpItemMenu = { fg = colors.green },
        }
    end

    if opts.override then
        M.bulk_hi(opts.override)
    end
end

return M
