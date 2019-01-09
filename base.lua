contentdb = {
  stores = {
    home = "content/home/"
  }
}

-- Methods for the model class
local model_metatable = {}
model_metatable.__index = model_metatable
function model_metatable:validate (object)
  for name, validator in pairs(self.fields) do
    local result, err = validator(object[name])
    if not result then
      return result, name .. ": " .. err
    end
  end
  return true
end

-- Add all directories in contentdb to the stores table
for entry in fs.entries("content/") do
  if fs.metadata("content/" .. entry).type == "directory" then
    contentdb.stores[entry] = "content/" .. entry .. "/"
  end
end


fs.create_dir("content/home", true)
