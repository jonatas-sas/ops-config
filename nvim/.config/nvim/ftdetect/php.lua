local php = require('opsconfig.modules.php')

vim.api.nvim_create_autocmd({
  'VimEnter',
  'BufReadPre',
  'BufNewFile',
}, {
  callback = function()
    vim.filetype.add({
      extension = {
        php = 'text',
      },
    })
  end,
})

vim.api.nvim_create_autocmd({
  'BufReadPost',
  'BufNewFile',
}, {
  pattern = '*.php',
  callback = function(args)
    local path = args.file
    local filename = vim.fn.fnamemodify(path, ':t')
    local is_config = php.ft.is_php_config(path, filename)
    local is_template = not is_config and php.ft.is_php_template(path, filename)
    local is_yii_migration = not is_config and php.ft.is_yii_migration(path)

    if is_config then
      vim.bo.filetype = 'php.config'
    elseif is_template then
      vim.bo.filetype = 'php.template'
    elseif is_yii_migration then
      vim.bo.filetype = 'php.yii.migration'
    else
      vim.bo.filetype = 'php'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php.config',
  desc = 'Configure options for PHP Configuration files',
  callback = function()
    print('PHP Config File Detected')

    local bufnr = vim.api.nvim_get_current_buf()

    local init_options = {
      ['language_level'] = '8.1',
      ['indexer.exclude_patterns'] = { '/vendor/', '/storage/', '/node_modules/' },
    }

    php.lsp.load_phpactor(bufnr, 'phpactor_config', init_options)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php.template',
  desc = 'Configure options for PHP Template files',
  callback = function()
    print('PHP Template File Detected')

    local bufnr = vim.api.nvim_get_current_buf()

    local init_options = {
      ['language_level'] = '8.1',
      ['indexer.exclude_patterns'] = { '/vendor/', '/storage/', '/node_modules/' },
    }

    php.lsp.load_phpactor(bufnr, 'phpactor_template', init_options)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php.yii.migration',
  desc = 'Configure options for Yii2 Migration files',
  callback = function()
    print('Yii2 Migration File Detected')

    local bufnr = vim.api.nvim_get_current_buf()

    local init_options = {
      ['language_level'] = '8.1',
      ['indexer.exclude_patterns'] = { '/vendor/', '/storage/', '/node_modules/' },
    }

    php.lsp.load_phpactor(bufnr, 'phpactor_yii_migration', init_options)
  end,
})
