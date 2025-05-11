return {
  -- NOTE:  Plugin avançado de folding para Neovim.
  --  Suporte a LSP, Treesitter e indentação para um folding mais preciso.
  --  Permite abrir e fechar folds de forma eficiente com atalhos personalizados.
  --  Integração com Lualine e pré-visualização de código dobrado.
  --  Repositório: https://github.com/kevinhwang91/nvim-ufo
  'kevinhwang91/nvim-ufo',

  enabled = vim.g.opsconfig.plugins.nvim_ufo
    and vim.g.opsconfig.plugins.promise_async
    and vim.g.opsconfig.plugins.nvim_lspconfig
    and vim.g.opsconfig.plugins.which_key_nvim
    and vim.g.opsconfig.plugins.nvim_treesitter,

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Biblioteca de Promises assíncronas para Neovim em Lua.
    --  Utilizada para facilitar operações assíncronas sem callbacks aninhados.
    --  Oferece uma API semelhante às Promises do JavaScript.
    --  Dependência essencial para plugins como nvim-ufo.
    --  Repositório: https://github.com/kevinhwang91/promise-async
    {
      'kevinhwang91/promise-async',
      enabled = true,
    },

    -- NOTE:  Coleção de configurações prontas para servidores LSP no Neovim.
    --  Facilita a configuração e gerenciamento de LSPs com opções personalizáveis.
    --  Integra-se com mason.nvim para instalação automática de servidores.
    --  Repositório: https://github.com/neovim/nvim-lspconfig
    {
      'neovim/nvim-lspconfig',
      enabled = true,
    },

    -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
    --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
    --  Ajuda a memorizar atalhos e melhorar a produtividade.
    --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
    --  Repositório: https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      enabled = true,
    },

    -- NOTE:  Fornece parsing avançado de código-fonte usando árvores sintáticas (Tree-sitter).
    --  Melhora realce de sintaxe, folds, indentação e análise estrutural do código.
    --  Suporte a múltiplas linguagens com instalação e atualização automática de parsers.
    --  Extensível, permitindo desenvolvimento de funcionalidades baseadas em árvore sintática.
    --  Repositório: https://github.com/nvim-treesitter/nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      enabled = true,
    },
  },

  -- }}}

  config = function()
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    local ufo = require('ufo')

    -- Setup {{{

    ufo.setup({
      enable_get_fold_virt_text = true,
      open_fold_hl_timeout = 150,

      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
        c = { 'comment', 'region' },
      },

      provider_selector = function(bufnr, filetype, _)
        -- print('[UFO] Provider called for ' .. filetype)

        if filetype == 'markdown' then
          -- print('[UFO] Using markdown provider')

          return function()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local folds = {}
            local stack = {}

            for i, line in ipairs(lines) do
              local hashes = line:match('^(#+)%s')
              if hashes then
                local level = #hashes

                while #stack > 0 and stack[#stack].level >= level do
                  local last = table.remove(stack)
                  last.finish = i - 2

                  if last.finish > last.start then
                    table.insert(folds, {
                      startLine = last.start,
                      endLine = last.finish,
                      kind = 'heading',
                    })
                  end
                end

                table.insert(stack, { level = level, start = i - 1 })
              end
            end

            for _, last in ipairs(stack) do
              last.finish = #lines - 1

              if last.finish > last.start then
                table.insert(folds, {
                  startLine = last.start,
                  endLine = last.finish,
                  kind = 'heading',
                })
              end
            end

            return folds
          end
        end
        return { 'treesitter', 'indent' }
      end,

      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },

        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
    })

    -- }}}
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.foldmethod = 'expr'
        vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end,
    })
    -- Keymaps {{{

    local wk = require('which-key')

    wk.add({
      {
        'zR',
        ufo.openAllFolds,
        desc = 'Open All Folds',
        icon = { color = 'green', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'zM',
        ufo.closeAllFolds,
        desc = 'Close All Folds',
        icon = { color = 'red', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'zr',
        ufo.openFoldsExceptKinds,
        desc = 'Open Folds Except Kinds',
        icon = { color = 'green', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'zm',
        ufo.closeFoldsWith,
        desc = 'Close Folds With',
        icon = { color = 'red', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        for i = 1, 6 do
          vim.keymap.set('n', string.format('<leader>mf%d', i), function()
            require('ufo').closeFoldsWith(i)
          end, { desc = 'Fold markdown heading level ' .. i })
        end
      end,
    })

    -- }}}
  end,
}
