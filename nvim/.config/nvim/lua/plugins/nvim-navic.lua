return {
  'LunarVim/breadcrumbs.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'SmiteshP/nvim-navic', -- backend for breadcrumbs
  },
  config = function()
    -- Setup navic first (with auto_attach)
    require('nvim-navic').setup {
      lsp = {
        auto_attach = true,
      },
    }

    -- Then setup breadcrumbs
    require('breadcrumbs').setup {
      -- optional configs
      -- disable_on_invalid_context = true,
      -- winbar = true,  -- enable winbar integration
      -- symbols = { ... }, -- customize icons
    }
  end,
}
