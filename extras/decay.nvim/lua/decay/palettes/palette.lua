local utbl = require "decay.utils.table"
local ucolor = require "decay.utils.color"
local ustring = require "decay.utils.string"

local palette = { mt = {}, _private = {} }
local setmetatable = setmetatable

function palette:get_colors()
  if not self._private.colorscheme then
    error("[decay:palette:error] this palette has no colors??")
  end

  return self._private.colorscheme
end

function palette:gen_color(key, original_key, lightness)
  self._private.colorscheme.colors[key] = ucolor.lighten(
    self._private.colorscheme.colors[original_key], lightness
  )
end

function palette:generate_colors()
  self:gen_color('background_0', 'background', -2)
  self:gen_color('background_1', 'background', 3)
  self:gen_color('background_2', 'background', 5)
  self:gen_color('background_3', 'background', 10)
  self:gen_color('black', 'background', 15)
  self:gen_color('black_1', 'background', 20)
  self:gen_color('black_2', 'background', 25)

  -- foreground there since we wanna ignore it
  local shades_colors = utbl {
    'background', 'background_0',
    'background_1', 'background_2',
    'background_3', 'black',
    'black_1', 'black_2', 'foreground',
  }

  local colors_copy = {}
  for k, v in pairs(self._private.colorscheme.colors) do
    colors_copy[k] = v
  end

  for color, hex in pairs(colors_copy) do
    if not shades_colors:contains(color) and not ustring(color):starts_with '_' then
      self._private.colorscheme.colors['light_' .. color] = ucolor.lighten(
        self._private.colorscheme.colors[color], 5
      )
    end
  end
end

function palette:run_generators()
  local generators = self._private.colorscheme.colors._generate or {}
  local generated_colors = {}

  for name, generator in pairs(generators) do
    generated_colors[name] = generator(self._private.colorscheme)
  end

  for k, v in pairs(generated_colors) do
    self._private.colorscheme.colors[k] = v
  end

  -- removing meta key `_generate`
  if not not self._private.colorscheme.colors._generate then
    self._private.colorscheme.colors._generate = nil
  end
end

function palette:from_dict(colorscheme)
  self._private.colorscheme = colorscheme
  self:generate_colors()
  self:run_generators()
  return self
end

local function new()
  return utbl({}):merge(palette)
end

function palette.mt:__call()
  return new()
end

return setmetatable(palette, palette.mt)
