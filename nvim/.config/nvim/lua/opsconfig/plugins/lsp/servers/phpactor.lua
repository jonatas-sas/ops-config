local M = {}

--- Generates configuration for the PHP language server.
---
--- @param  capabilities table LSP client capabilities, usually extended via cmp_nvim_lsp.
--- @param  flags table LSP flags such as debounce settings.
---
--- @return table Config table for use with `lspconfig.phpactor.setup`.
M.config = function(capabilities, flags)
  local lspconfig = require('lspconfig')

  return {
    cmd = { 'phpactor', 'language-server' },

    filetypes = { 'php' },

    root_dir = lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.json', '.phpactor.yml'),

    -- on_attach = function(client, bufnr)
    --   if vim.bo[bufnr].filetype == 'php.config' then
    --     client.stop()
    --   end
    -- end,

    settings = {
      phpactor = {
        indexing = {
          exclude = {
            'node_modules',
            'storage',
            'runtime',
            'cache',
            'tests',
            'tmp',
            'temp',
            'assets',
            'storage',
          },
        },

        completion = {
          enable = true,
        },

        diagnostics = {
          enable = true,
        },

        inlay_hints = {
          enable = false,
        },

        lsp = {
          enabled = true,
          completion = true,
          code_lens = false,
          hover = true,
          rename = true,
          folding = true,
        },
      },
    },

    flags = flags,

    capabilities = capabilities,
  }
end

return M
