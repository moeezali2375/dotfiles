vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Create a group so the autocmd doesn't duplicate on reload
local csv_group = vim.api.nvim_create_augroup('csv_auto_view', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = csv_group,
  pattern = { 'csv', 'tsv' },
  callback = function()
    -- We use pcall (protected call) to prevent errors if the plugin isn't installed
    pcall(vim.cmd, 'CsvViewEnable')
  end,
  desc = 'Automatically enable csvview for CSV and TSV files',
})
