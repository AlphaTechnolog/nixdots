---@diagnostic disable: undefined-global
local present, lualine = pcall(require, 'lualine')

-- make the right theme
local decay_lualine = require 'lualine.themes.decay'
local decay_colors = require 'decay.core'.get_colors(vim.g.decay_style)
local opts = require 'common'

local theme = decay_lualine

local function override_color(mode, color_key)
	theme[mode].a.bg = decay_colors.statusline_bg
	theme[mode].a.fg = decay_colors[color_key]
	if opts.italic then
		theme[mode].a.gui = 'italic'
	end
end

local colors = {
	normal = 'blue',
	insert = 'green',
	command = 'yellow',
	visual = 'magenta',
	replace = 'red',
	inactive = 'foreground'
}

for mode, color in pairs(colors) do
	override_color(mode, color)
end

-- start
if not present then
	return
end

local layout = {
	lualine_a = {
		{
			function ()
				return ''
			end,
			padding = { left = 1, right = 0 },
		},
		{
			'mode',
			fmt = string.lower,
		},
		{
			'location',
			color = { fg = decay_colors.brightblack, bg = decay_colors.statusline_bg }
		},
	},
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = {
		{
			'branch',
			color = { fg = decay_colors.yellow, bg = decay_colors.statusline_bg },
		},
		{
			'filename',
			color = { fg = decay_colors.brightblack, bg = decay_colors.statusline_bg }
		}
	},
}

local no_layout = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = {},
}

lualine.setup {
	sections = layout,
	inactive_sections = no_layout,
	options = {
		globalstatus = true,
		theme = theme,
		section_separators = { left = nil, right = nil },
		component_separators = { left = nil, right = nil }
	},
}
