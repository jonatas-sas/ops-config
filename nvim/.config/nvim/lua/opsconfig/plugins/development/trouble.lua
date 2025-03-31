return {
  -- NOTE:  Exibe diagnósticos, quickfix, LSP references e todo-comments em uma lista organizada.
  --  Interface intuitiva para navegação rápida entre erros e avisos.
  --  Integra-se com LSP, Telescope, todo-comments e outros plugins.
  --  Suporte a atalhos para abrir, fechar e filtrar resultados facilmente.
  --  Repositório: https://github.com/folke/trouble.nvim
  'folke/trouble.nvim',

  enabled = vim.g.opsconfig.plugins.trouble_nvim,

  dependencies = {
    -- NOTE:  Ícones para arquivos e diretórios no Neovim.
    --  Integra-se com plugins como nvim-tree, telescope e lualine.
    --  Suporte a múltiplos temas e personalização de ícones.
    --  Requer uma fonte Nerd Font para exibição correta.
    --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.opsconfig.plugins.nvim_web_devicons,
    },

    -- NOTE: Realça e gerencia comentários como TODO, FIX, HACK e outros no código.
    -- Suporte a destaque visual, navegação e integração com Telescope.
    -- Permite adicionar palavras-chave personalizadas para melhor organização.
    -- Repositório: https://github.com/folke/todo-comments.nvim
    {
      'folke/todo-comments.nvim',
      enabled = vim.g.opsconfig.plugins.todo_comments_nvim,
    },
  },

  opts = {
    position = 'bottom', -- Posição da janela (pode ser "bottom", "top", "left", "right")
    height = 12, -- Altura da janela (se estiver no topo ou embaixo)
    width = 50, -- Largura da janela (se estiver na lateral)
    padding = false, -- Remove padding para economizar espaço
    cycle_results = true, -- Habilita a rotação de resultados ao navegar com <C-n> e <C-p>
    auto_jump = false, -- Não pula automaticamente para o primeiro erro
    auto_close = true, -- Fecha o Trouble automaticamente se estiver vazio
    auto_preview = true, -- Mostra automaticamente o preview do erro
    icons = true, -- Usa ícones da Nerd Font para exibição dos erros
    use_diagnostic_signs = true, -- Usa os símbolos de diagnóstico configurados no Neovim
    sort_keys = {
      'severity', -- Ordena por severidade primeiro
      'filename',
    },
    focus = true,
  },

  cmd = 'Trouble',

  config = function()
    local wk = require('which-key')
    local trouble = require('trouble').api

    wk.add({
      { '<leader>x', group = '󰙨 Trouble', icon = '' },

      -- Original Keybindings
      {
        '<leader>xx',
        trouble.toggle,
        desc = 'Toggle Trouble',
        icon = { color = 'yellow', icon = '󰅃' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>xw',
        function()
          trouble.toggle('workspace_diagnostics')
        end,
        desc = 'Workspace Diagnostics',
        icon = { color = 'purple', icon = '󰭭' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>xd',
        function()
          trouble.toggle('document_diagnostics')
        end,
        desc = 'Document Diagnostics',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>xq',
        function()
          trouble.toggle('quickfix')
        end,
        desc = 'Quickfix',
        icon = { color = 'blue', icon = '󰗍' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>xl',
        function()
          trouble.toggle('loclist')
        end,
        desc = 'Location List',
        icon = { color = 'yellow', icon = '󰑕' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>xR',
        function()
          trouble.toggle('lsp_references')
        end,
        desc = 'LSP References',
        icon = { color = 'green', icon = '󰆿' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '[d',
        vim.diagnostic.goto_prev,
        desc = 'Previous Diagnostic',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        ']d',
        vim.diagnostic.goto_next,
        desc = 'Next Diagnostic',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>q',
        vim.diagnostic.setloclist,
        desc = 'Add to Quickfix',
        icon = { color = 'blue', icon = '󰗍' },
        mode = 'n',
        noremap = true,
        silent = true,
      },

      -- Fast Bindings (Mod Keys)
      {
        '<C-S-T>',
        trouble.toggle,
        desc = 'Toggle Trouble',
        icon = { color = 'yellow', icon = '󰅃' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-W>',
        function()
          trouble.toggle('workspace_diagnostics')
        end,
        desc = 'Workspace Diagnostics',
        icon = { color = 'purple', icon = '󰭭' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-D>',
        function()
          trouble.toggle('document_diagnostics')
        end,
        desc = 'Document Diagnostics',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-Q>',
        function()
          trouble.toggle('quickfix')
        end,
        desc = 'Quickfix',
        icon = { color = 'blue', icon = '󰗍' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-L>',
        function()
          trouble.toggle('loclist')
        end,
        desc = 'Location List',
        icon = { color = 'yellow', icon = '󰑕' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-R>',
        function()
          trouble.toggle('lsp_references')
        end,
        desc = 'LSP References',
        icon = { color = 'green', icon = '󰆿' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-K>',
        vim.diagnostic.goto_prev,
        desc = 'Previous Diagnostic',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-J>',
        vim.diagnostic.goto_next,
        desc = 'Next Diagnostic',
        icon = { color = 'red', icon = '󰗖' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })
  end,
}
