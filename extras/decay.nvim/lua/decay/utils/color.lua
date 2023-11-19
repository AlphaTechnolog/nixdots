local tonumber = tonumber
local string = string
local math = math
local abs = math.abs
local floor = math.floor
local max = math.max
local min = math.min
local random = math.random
local format = string.format

local _color = {}

-- Returns a value that is clipped to interval edges if it falls outside the interval
local function clip(num, min_num, max_num)
  return max(min(num, max_num), min_num)
end

-- Color utils extracted from tokyonight.nvim
function _color.blend(foreground, background, alpha)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha

  local function hex_to_rgb(c)
    c = string.lower(c)
    return {
      tonumber(c:sub(2, 3), 16),
      tonumber(c:sub(4, 5), 16),
      tonumber(c:sub(6, 7), 16),
    }
  end

  local bg, fg = hex_to_rgb(background), hex_to_rgb(foreground)

  local function blend_channel(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blend_channel(1), blend_channel(2), blend_channel(3))
end

-- Darkens a color, mostly used for blending of colors to the dark
function _color.sutil_darken(hex, amount, bg)
  return _color.blend(hex, bg or "#000000", amount)
end

-- Lightens a color, see `_color.sutil_darken` to read the purpose of these
-- kind of functions, and why using these rather than `_color.lighten` (per example)
function _color.sutil_lighten(hex, amount, fg)
  return _color.blend(hex, fg or "#ffffff", amount)
end

-- Converts the given hex color to hsv
function _color.hex_to_hsv(color)
  local color = _color.hex_to_rgba(color)
  local C_max = max(color.r, color.g, color.b)
  local C_min = min(color.r, color.g, color.b)
  local delta = C_max - C_min
  local H, S, V
  if delta == 0 then
    H = 0
  elseif C_max == color.r then
    H = 60 * (((color.g - color.b) / delta) % 6)
  elseif C_max == color.g then
    H = 60 * (((color.b - color.r) / delta) + 2)
  elseif C_max == color.b then
    H = 60 * (((color.r - color.g) / delta) + 4)
  end
  if C_max == 0 then
    S = 0
  else
    S = delta / C_max
  end
  V = C_max

  return { h = H, s = S * 100, v = V * 100 }
end

-- Converts the given hsv color to hex
function _color.hsv_to_hex(H, S, V)
  S = S / 100
  V = V / 100
  if H > 360 then
    H = 360
  end
  if H < 0 then
    H = 0
  end
  local C = V * S
  local X = C * (1 - abs(((H / 60) % 2) - 1))
  local m = V - C
  local r_, g_, b_ = 0, 0, 0
  if H >= 0 and H < 60 then
    r_, g_, b_ = C, X, 0
  elseif H >= 60 and H < 120 then
    r_, g_, b_ = X, C, 0
  elseif H >= 120 and H < 180 then
    r_, g_, b_ = 0, C, X
  elseif H >= 180 and H < 240 then
    r_, g_, b_ = 0, X, C
  elseif H >= 240 and H < 300 then
    r_, g_, b_ = X, 0, C
  elseif H >= 300 and H < 360 then
    r_, g_, b_ = C, 0, X
  end
  local r, g, b = (r_ + m) * 255, (g_ + m) * 255, (b_ + m) * 255
  return ("#%02x%02x%02x"):format(floor(r), floor(g), floor(b))
end

-- Calculates the contrast ratio between the two given colors
function _color.contrast_ratio(fg, bg)
  return (_color.relative_luminance(fg) + 0.05) / (_color.relative_luminance(bg) + 0.05)
end

-- Returns true if the contrast between the two given colors is suitable
function _color.is_contrast_acceptable(fg, bg)
  return _color.contrast_ratio(fg, bg) >= 7 and true
end

--- Try to guess if a color is dark or light.
function _color.is_dark(color)
  local numeric_value = 0
  for s in color:gmatch "[a-fA-F0-9][a-fA-F0-9]" do
    numeric_value = numeric_value + tonumber("0x" .. s)
  end

  return (numeric_value < 383)
end

--- Check if a color is opaque.
function _color.is_opaque(color)
  if type(color) == "string" then
    color = _color.hex_to_rgba(color)
  end

  return color.a < 0.01
end

-- Lightens a given hex color by the specified amount
function _color.lighten(color, amount)
  amount = amount or 26
  local c = {
    r = tonumber("0x" .. color:sub(2, 3)),
    g = tonumber("0x" .. color:sub(4, 5)),
    b = tonumber("0x" .. color:sub(6, 7)),
  }

  c.r = c.r + amount
  c.r = c.r < 0 and 0 or c.r
  c.r = c.r > 255 and 255 or c.r
  c.g = c.g + amount
  c.g = c.g < 0 and 0 or c.g
  c.g = c.g > 255 and 255 or c.g
  c.b = c.b + amount
  c.b = c.b < 0 and 0 or c.b
  c.b = c.b > 255 and 255 or c.b

  return string.format("#%02x%02x%02x", c.r, c.g, c.b)
end

-- Darkens a given hex color by the specified amount
function _color.darken(color, amount)
  amount = amount or 26
  return _color.lighten(color, -amount)
end

return _color
