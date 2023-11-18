local utbl = require "decay.utils.table"

local theme_resolver = { mt = {}, _private = {} }
local setmetatable = setmetatable

function theme_resolver:resolve(config)
  local scheme = config.options.scheme
  local exists, theme = pcall(require, "decay.palettes." .. scheme)

  if not exists then
    error("[decay:theme_resolver:resolve()]: cannot resolve scheme: " .. scheme .. " (reason: " .. theme .. ")")
  end

  return theme:get_colors()
end

local function new()
  return utbl({}):merge(theme_resolver)
end

function theme_resolver.mt:__call()
  return new()
end

return setmetatable(theme_resolver, theme_resolver.mt)
