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

vim.api.nvim_create_user_command('JsProjectInit', function()
  local cwd = vim.fn.getcwd()

  -- 1. Run npm init -y
  vim.notify('Initializing npm project...')
  vim.fn.system 'npm init -y'

  -- 2. Generate jsconfig.json
  local jsconfig_path = cwd .. '/jsconfig.json'
  local jsconfig_content = [[
{
  "compilerOptions": {
    "module": "ESNext",
    "target": "ESNext",
    "checkJs": true,
    "jsx": "react",
    "moduleResolution": "node",
    "baseUrl": "./"
  },
  "exclude": ["node_modules", "dist"]
}
]]
  local f = io.open(jsconfig_path, 'w')
  if f then
    f:write(jsconfig_content)
    f:close()
  end

  -- 3. Generate eslint.config.mjs (Matching your settings: ESM, Browser, No TS)
  local eslint_path = cwd .. '/eslint.config.mjs'
  local eslint_content = [[
import globals from "globals";
import pluginJs from "@eslint/js";

export default [
  { languageOptions: { globals: globals.browser } },
  pluginJs.configs.recommended,
];
]]
  local f_eslint = io.open(eslint_path, 'w')
  if f_eslint then
    f_eslint:write(eslint_content)
    f_eslint:close()
  end

  -- 4. Install dependencies in the background
  vim.notify('Installing eslint and globals...')
  vim.fn.jobstart('npm install eslint globals @eslint/js --save-dev', {
    on_exit = function()
      vim.notify 'JS Project initialized successfully with ESLint and jsconfig!'
    end,
  })
end, { desc = 'Initialize a JS project with npm, jsconfig, and ESLint' })
