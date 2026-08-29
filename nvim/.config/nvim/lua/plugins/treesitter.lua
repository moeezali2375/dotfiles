
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      }
      ts.install(ensure_installed)

      -- Automatically install missing parsers when opening a new filetype
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_auto_install', { clear = true }),
        callback = function(args)
          local ft = args.match
          if not ft or ft == '' then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft) or ft
          local available = ts.get_available()

          if vim.list_contains(available, lang) then
            local installed = ts.get_installed()
            if not vim.list_contains(installed, lang) then
              ts.install(lang)
            end
          end
        end,
        desc = 'Automatically install missing Treesitter parsers on FileType',
      })
    end,
  },
}
