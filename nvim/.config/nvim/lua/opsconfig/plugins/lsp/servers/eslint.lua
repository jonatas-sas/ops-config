local M = {}

--- Generates configuration for the ESLint language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.eslint.setup`.
M.config = function(capabilities, flags)
  return {
    root_dir = require('lspconfig.util').root_pattern('eslint.config.mjs', 'eslint.config.js', 'package.json', '.git'),

    settings = {
      experimental = {
        enableCodeLens = true,
        useFlatConfig = true,
      },
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = 'line',
        },
        showDocumentation = {
          enable = true,
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end

return M
