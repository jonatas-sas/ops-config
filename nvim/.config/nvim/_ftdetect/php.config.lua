local ft = 'php.config'

vim.api.nvim_create_autocmd({
  'BufReadPre',
  'BufNewFile',
}, {
  pattern = '*.php',
  callback = function(args)
    local php = require('opsconfig.modules.languages.php.filetypes')
    local path = args.file
    local filename = vim.fn.fnamemodify(path, ':t')
    local valid = php.is_php_config(path, filename)

    if valid then
      vim.bo.filetype = ft
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = ft,
  desc = 'Configure options for PHP Configuration files',
  callback = function()
    print('PHP Config File Detected')

    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.name == 'phpactor' then
        return -- já está attachado, não reinicia
      end
    end

    local capabilities, flags = require('opsconfig.plugins.lsp.config.lsp').default_config()

    vim.lsp.start({
      name = 'phpactor_config',

      cmd = {
        'phpactor',
        'language-server',
      },

      root_dir = vim.fn.getcwd(),

      settings = {},

      init_options = {
        ['language_level'] = '7.4',
        ['code_transform.import_names'] = true,
        ['code_transform.sort_imports'] = false,
        ['completion.trim_leading_dollar'] = false,
        ['indexer.exclude_patterns'] = { '/vendor/', '/storage/', '/node_modules/' },
      },

      capabilities = capabilities,

      flags = flags,
    })
  end,
})
