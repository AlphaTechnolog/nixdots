local utbl = require "decay.utils.table"

local ThemeResolver = require "decay.theme-resolver"
local Colorizer = require "decay.colorizer"

local decay = { mt = {}, _private = {} }
local setmetatable = setmetatable

function decay:validate_config()
  self._private.config = self._private.config or {}
  self._private.config.options = self._private.config.options or {}
  self._private.config.options.scheme = self._private.config.options.scheme or "default"
  self._private.config.styles = self._private.config.styles or {}
  for _, i in ipairs {'comments', 'keywords', 'variables', 'functions', 'sidebars', 'floats'} do
    self._private.config.styles[i] = self._private.config.styles[i] or {}
  end
end

function decay:setup()
  local ok, err = pcall(function ()
    self._private.colorizer:colorize(self._private.theme_resolver:resolve(
      self._private.config
    ))
  end)

  if not ok then
    error("[decay:error]: unexpected error ocurred when attempting to colorize nvim, reason: " .. tostring(err))
  end
end

local function new(config)
  local ret = utbl({}):merge(decay)

  ret._private.config = config
  ret:validate_config()

  ret._private.theme_resolver = ThemeResolver()
  ret._private.colorizer = Colorizer(ret._private.config)

  return ret
end

function decay.mt:__call(...)
  return new(...)
end

return setmetatable(decay, decay.mt)
