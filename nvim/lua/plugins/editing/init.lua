local modules = {
  "plugins.editing.ai",
  "plugins.editing.formatting",
  "plugins.editing.syntax",
  "plugins.editing.editor",
}

local specs = {}
for _, module in ipairs(modules) do
  vim.list_extend(specs, require(module))
end

return specs
