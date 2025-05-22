M = {}

--- Generates default LSP capabilities and flags.
---
--- @return table capabilities Extended LSP client capabilities.
--- @return table flags LSP flags such as debounce settings.
M.default_config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local flags = {
    debounce_text_changes = 150,
  }

  return capabilities, flags
end

return M
