return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Document highlights (references of the word under cursor)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Set up capabilities for LSP clients
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Define LSP servers and their configurations
      local servers = {
        -- Add or remove LSP servers here. Mason will auto-install them.
        -- Example: clangd = {}, pyright = {}, rust_analyzer = {}, ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        ts_ls = {
          single_file_support = true,
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
          end,
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
          init_options = {
            hostInfo = 'neovim',
            preferences = {
              includeCompletionsForModuleExports = true,
            },
          },
        },
        tsserver = {
          single_file_support = true,
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname)
          end,
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        },
        sourcekit = {
          cmd = { 'sourcekit-lsp' },
          filetypes = { 'swift', 'c', 'cpp', 'objective-c', 'objective-cpp' },
          root_dir = function(bufnr_or_fname, on_dir)
            local fname = type(bufnr_or_fname) == 'number' and vim.api.nvim_buf_get_name(bufnr_or_fname) or bufnr_or_fname
            local root = require('lspconfig.util').root_pattern('buildServer.json', '*.xcodeproj', '*.xcworkspace', 'Package.swift', '.git')(fname)
            if type(on_dir) == 'function' then
              on_dir(root)
            end
            return root
          end,
        },
      }

      -- Mason setup for managing LSP servers and tools
      require('mason').setup()

      -- Auto-install Mason packages
      local ok, registry = pcall(require, 'mason-registry')
      if not ok then
        return
      end

      -- NOTE: If you have a separate file for mason packages (e.g., lua/mason-packages.lua)
      --       you would require it here. For this example, we'll define a simple list.
      -- Load your custom package list
      local mason_packages_to_install = require 'mason-packages'

      -- ensure stylua is always the first in the list
      local ensure_installed = { 'stylua' }
      for _, pkg in ipairs(mason_packages_to_install) do
        if pkg ~= 'stylua' then
          table.insert(ensure_installed, pkg)
        end
      end

      -- Use mason-tool-installer to keep them in sync
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        run_on_start = true,
      }

      require('mason-auto-sync').setup()

      -- Load lspconfig defaults into vim.lsp.config
      local lspconfig = require('lspconfig')

      -- Configure mason-lspconfig to set up LSP servers using native vim.lsp APIs
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local default_config = vim.lsp.config[server_name] or {}
            local user_config = servers[server_name] or {}
            local server = vim.tbl_deep_extend('force', default_config, user_config)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
            vim.lsp.enable(server_name)
          end,
        },
      }

      -- Explicit setup for system-installed sourcekit-lsp (not managed by Mason)
      local default_sourcekit = vim.lsp.config.sourcekit or {}
      local user_sourcekit = servers.sourcekit or {}
      local sourcekit_opts = vim.tbl_deep_extend('force', default_sourcekit, user_sourcekit)
      sourcekit_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, sourcekit_opts.capabilities or {})
      vim.lsp.config('sourcekit', sourcekit_opts)
      vim.lsp.enable('sourcekit')
    end,
  },
}
