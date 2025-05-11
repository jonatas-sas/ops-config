local M = {}

--- Generates configuration for the Python language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.pyright.setup`.
M.config = function(capabilities, flags)
  return {
    flags = flags,

    capabilities = capabilities,
  }
end

return M
