-- NOTE: MASON AUTO SYNC
local M = {}

function M.dump_installed_packages()
  local registry = require 'mason-registry'
  local installed = registry.get_installed_packages()
  local names = {}

  for _, pkg in ipairs(installed) do
    table.insert(names, pkg.name)
  end

  local file_path = vim.fn.stdpath 'config' .. '/lua/mason-packages.lua'
  local file = io.open(file_path, 'w')

  if file then
    file:write('return ' .. vim.inspect(names))
    file:close()

    vim.defer_fn(function()
      vim.fn.system { 'stylua', file_path }
    end, 50)
    vim.notify(file_path)

    vim.notify('Updated mason-packages.lua', vim.log.levels.INFO)
  else
    vim.notify('Failed to write mason-packages.lua', vim.log.levels.ERROR)
  end
end

-- Setup event hooks so only installs/uninstalls trigger a dump
function M.setup()
  local registry = require 'mason-registry'

  -- Only dump on Mason events (no startup run)
  registry:on('package:install:success', function(_)
    M.dump_installed_packages()
  end)

  registry:on('package:uninstall:success', function(_)
    M.dump_installed_packages()
  end)
end

return M
