local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('opsconfig-lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- Inlay Hints {{{

      if client and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end

      -- }}}

      -- Client Actions {{{

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if client then
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('opsconfig-lsp-highlight', { clear = false })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('opsconfig-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'opsconfig-lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        client.handlers['textDocument/hover'] = function(_, result, _, _)
          local bufnr, winnr = vim.lsp.util.open_floating_preview(result and result.contents or {}, 'markdown', {
            border = 'rounded',
            focusable = false,
            style = 'minimal',
            relative = 'cursor',
            width = 60,
            max_width = 80,
            max_height = 20,
          })

          if winnr then
            vim.api.nvim_win_set_option(winnr, 'winhighlight', 'Normal:NormalFloat,FloatBorder:FloatBorder')
          end

          return bufnr, winnr
        end

        vim.cmd([[
hi NormalFloat guibg=#1e1e2e
hi FloatBorder guibg=#1e1e2e guifg=#89b4fa
]])
      end
    end,
  })
end

return M
