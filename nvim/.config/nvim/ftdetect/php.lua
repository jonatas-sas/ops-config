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
    local php = require('opsconfig.modules.languages.php.filetypes')
    local path = args.file
    local filename = vim.fn.fnamemodify(path, ':t')
    local is_config = php.is_php_config(path, filename)
    local is_template = not is_config and php.is_php_template(path, filename)

    if is_config then
      vim.bo.filetype = 'php.config'
    elseif is_template then
      vim.bo.filetype = 'php.template'
    else
      vim.bo.filetype = 'php'
    end
  end,
})

local load_phpactor = function(bufnr, init_options)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    if client.name == 'phpactor' then
      return
    end
  end

  local capabilities, flags = require('opsconfig.plugins.lsp.config.lsp').default_config()

  vim.lsp.start({
    name = 'phpactor_config',

    cmd = { 'phpactor', 'language-server' },

    root_dir = vim.fn.getcwd(),

    settings = {},

    init_options = init_options,

    capabilities = capabilities,

    flags = flags,
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php.config',
  desc = 'Configure options for PHP Configuration files',
  callback = function()
    print('PHP Config File Detected')

    local bufnr = vim.api.nvim_get_current_buf()

    local init_options = {
      ['language_level'] = '7.4',
      ['code_transform.import_names'] = false,
      ['code_transform.sort_imports'] = false,
      ['completion.trim_leading_dollar'] = false,
      ['indexer.exclude_patterns'] = { '/vendor/', '/storage/', '/node_modules/' },
      ['language_server.diagnostic_ignore_codes'] = { 'fix_namespace_class_name' },
    }

    load_phpactor(bufnr, init_options)
  end,
})
