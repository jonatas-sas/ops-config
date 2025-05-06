local M = {}

-- SECTION: General
local opts = { noremap = true, silent = true }

M.map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
end

-- SECTION: Buffers

M.buffers = {}

M.buffers.close_others = function()
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' then
      vim.cmd('bd ' .. buf)
    end
  end
end

-- SECTION: LSP

M.lsp = {}

M.lsp.format_code = function()
  vim.lsp.buf.format({ async = true })
end

M.lsp.toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
end

M.lsp.restart = function()
  for _, client in pairs(vim.lsp.get_active_clients()) do
    client.stop()
  end

  vim.defer_fn(function()
    local configs = require('lspconfig.configs')

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == '' then
        for _, config in pairs(configs) do
          if config.manager then
            config.manager.try_add(bufnr)
          end
        end
      end
    end
  end, 100)
end

-- SECTION: Plugins
-- SUBSECTION: Conform
M.conform = {}

M.conform.format = function(options)
  options = options or {}

  require('conform').format(options)
end

-- SUBSECTION: Oil
M.oil = {}

M.oil.open = function()
  require('oil').open_float(vim.fn.expand('%:p:h'))
end

M.oil.open_root = function()
  require('oil').open_float(vim.fn.getcwd())
end

return M
