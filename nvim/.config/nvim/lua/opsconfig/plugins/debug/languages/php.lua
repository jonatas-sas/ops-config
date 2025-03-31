if vim.g.opsconfig.global.languages.php.enabled and vim.g.opsconfig.global.languages.php.xdebug then
  local dap = require('dap')

  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {
      require('mason-registry').get_package('php-debug-adapter'):get_install_path() .. '/extension/out/phpDebug.js',
    },
  }

  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9003,
      stopOnEntry = false,
    },
  }

  -- Inteliphense {{{

  if vim.g.opsconfig.global.languages.php.intelephense then
    dap.listeners.before.event_initialized['disable_intelephense'] = function()
      vim.lsp.stop_client(vim.lsp.get_active_clients({ name = 'intelephense' }))
    end

    dap.listeners.before.event_terminated['enable_intelephense'] = function()
      vim.cmd('LspStart intelephense')
    end
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'DAPStarted',
    callback = function()
      vim.b.format_on_save = false
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    pattern = 'DAPTerminated',
    callback = function()
      vim.b.format_on_save = true
    end,
  })
  -- }}}
end
