local M = {}

function M.merge_table(table, new_table)
  for key, val in pairs(new_table) do
    table[key] = val
  end
end

function M.has_key(table, thekey)
  found = false
  for key, _ in pairs(table) do
    if key == thekey then
      found = true
    end
  end

  return found
end

function M.process_table(processor, table)
  for key, val in pairs(table) do
    processor(key, val)
  end
end

return M
