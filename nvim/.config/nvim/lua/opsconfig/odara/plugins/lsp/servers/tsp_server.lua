local M = {}

--- Generates configuration for the JavaScript and TypeScript language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.tsp_server.setup`.
M.config = function(capabilities, flags)
  return {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },

      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayVariableTypeHints = true,
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end

return M
