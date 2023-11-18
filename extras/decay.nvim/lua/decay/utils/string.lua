local utbl = require "decay.utils.table"

local _string = { mt = {}, _private = {} }
local string = string
local setmetatable = setmetatable

function _string:starts_with(query)
  return string.sub(self._private.base_string, 1, string.len(query)) == query
end

local function new(base_string)
  local ret = utbl({}):merge(_string)
  ret._private.base_string = base_string
  return ret
end

function _string.mt:__call(...)
  return new(...)
end

return setmetatable(_string, _string.mt)
