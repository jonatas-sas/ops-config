local ft = 'php.template'

vim.api.nvim_create_autocmd({
  'VimEnter',
  'BufRead',
  'BufNewFile',
}, {
  pattern = '*.php',
  callback = function(args)
    local php = require('opsconfig.modules.languages.php.filetypes')
    local path = args.file
    local valid = php.is_php_template(path)

    if valid then
      vim.bo.filetype = ft
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = ft,
  desc = 'Configure options for PHP Template files',
  callback = function()
    vim.b.hi = 'PHP Config'
    print('PHP Template file detected')
  end,
})
