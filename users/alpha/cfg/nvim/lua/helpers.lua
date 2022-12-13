local M = {}

M.dict_contains = function (table, value)
  contains = false
  for key, _ in pairs(table) do
    if value == key then
      contains = true
    end
  end

  return contains
end

M.list_contains = function (table, value)
  contains = false
  for _, item in ipairs(table) do
    if value == item then
      contains = true
    end
  end

  return contains
end

return M
