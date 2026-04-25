local modules = {
  "plugins.core",
  "plugins.navigation",
  "plugins.lsp",
  "plugins.git",
  "plugins.ui",
  "plugins.debug",
  "plugins.editing",
}

local specs = {}
for _, module in ipairs(modules) do
  vim.list_extend(specs, require(module))
end

return specs
