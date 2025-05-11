local M = {}

--- Generates configuration for the PHP language server (Intelephense).
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.intelephense.setup`.
M.config = function(capabilities, flags)
  local intelephense_key = os.getenv('OPSCONFIG_INTELEPHENSE_KEY') or ''

  return {
    cmd = { 'intelephense', '--stdio' },

    init_options = {
      licenceKey = intelephense_key,
    },

    settings = {
      intelephense = {
        stubs = {
          'bcmath',
          'bz2',
          'Core',
          'curl',
          'date',
          'dom',
          'fileinfo',
          'filter',
          'gd',
          'json',
          'libxml',
          'mbstring',
          'mysqli',
          'openssl',
          'pcntl',
          'pcre',
          'PDO',
          'pdo_mysql',
          'readline',
          'Reflection',
          'session',
          'SimpleXML',
          'sockets',
          'sodium',
          'SPL',
          'standard',
          'tokenizer',
          'xml',
          'zip',
          'zlib',
          'wordpress',
          'woocommerce',
          'phpunit',
          'composer',
        },

        environment = {
          includePaths = { 'vendor' },
        },

        format = {
          enable = false,
        },

        files = {
          maxSize = 5000000,
          exclude = {
            '**/node_modules/**',
            '**/.git/**',
            '**/storage/**',
            '**/cache/**',
            '**/runtime/**',
          },
        },

        diagnostics = {
          enable = true,
        },

        completion = {
          fullyQualifyGlobalConstants = true,
          insertUseDeclaration = true,
          triggerParameterHints = true,
          maxItems = 100,
        },

        indexing = {
          exclude = {
            '**/node_modules/**',
            '**/.git/**',
            '**/storage/**',
            '**/cache/**',
            '**/runtime/**',
          },
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end

return M
