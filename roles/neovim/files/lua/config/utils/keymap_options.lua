
local function opts(desc, module_name)
  local name = ""
  if module_name then
    name = module_name .. ": "
  end

  return { 
    desc = name .. desc, 
    -- buffer = bufnr, 
    noremap = true, 
    silent = true, 
    nowait = true 
  }
end

return {
  opts = opts
}