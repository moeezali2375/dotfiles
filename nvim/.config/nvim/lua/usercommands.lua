vim.api.nvim_create_user_command('MasonDump', function()
  local registry = require 'mason-registry'
  local installed = registry.get_installed_packages()
  local names = {}
  for _, pkg in ipairs(installed) do
    table.insert(names, pkg.name)
  end

  local file = io.open(vim.fn.stdpath 'config' .. '/lua/mason-packages.lua', 'w')
  file:write('return ' .. vim.inspect(names))
  file:close()
  vim.notify 'Dumped Mason packages to mason-packages.lua'
end, {})
