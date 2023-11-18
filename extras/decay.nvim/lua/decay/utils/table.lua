local tbl = { mt = {}, _private = {} }
local setmetatable = setmetatable

function tbl:get()
  return self._private.base_table
end

function tbl:merge(second_table)
  for key, value in pairs(second_table) do
    self._private.base_table[key] = value
  end

  return self._private.base_table
end

function tbl:includes(value)
  for key, _ in pairs(self._private.base_table) do
    if key == value then
      return true
    end
  end
  return false
end

function tbl:contains(query)
  for _, value in ipairs(self._private.base_table) do
    if value == query then
      return true
    end
  end
  return false
end

function tbl:copy()
  local ret = {}
  for k, v in pairs(self._private.base_table) do
    ret[k] = v
  end
  return ret
end

local function new(base_table)
  local ret = {}

  -- legacy merging
  for key, value in pairs(tbl) do
    ret[key] = value
  end

  ret._private.base_table = base_table

  return ret
end

function tbl.mt:__call(...)
  return new(...)
end

return setmetatable(tbl, tbl.mt)
