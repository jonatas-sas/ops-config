local M = {}

--- Generates configuration for the Go language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.gopls.setup`.
M.config = function(capabilities, flags)
  return {
    cmd = { 'gopls' },

    settings = {
      gopls = {
        usePlaceholders = true,
        staticcheck = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end
return M
