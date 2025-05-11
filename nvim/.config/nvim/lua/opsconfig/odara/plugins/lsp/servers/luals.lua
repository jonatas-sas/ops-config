local M = {}

--- Generates configuration for the Lua language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.lua_ls.setup`.
M.config = function(capabilities, flags)
  return {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },

        diagnostics = {
          globals = { 'vim' },
        },

        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },

        telemetry = {
          enable = false,
        },

        hint = {
          enable = true,
          arrayIndex = 'Disable',
          paramName = 'All',
          paramType = true,
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end
return M
