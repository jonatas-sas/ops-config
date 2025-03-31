return {
  -- NOTE:  Adiciona guias visuais para indentação no Neovim.
  --  Suporte a Treesitter e detecção de escopo para indentação inteligente.
  --  Configuração flexível para exibir níveis de indentação e linhas virtuais.
  --  Compatível com modos escuros e integração com temas.
  --  Repositório: https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',

  enabled = vim.g.opsconfig.plugins.indent_blankline_nvim,

  main = 'ibl',

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  config = function()
    local ibl = require('ibl')

    -- Define cores customizadas para os níveis de indentação
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = '#4b4b4b', nocombine = true }) -- cinza escuro
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = '#565f89', nocombine = true }) -- cinza arroxeado (tokyonight)
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = '#3b4261', nocombine = true }) -- azul acinzentado
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = '#2e3c64', nocombine = true }) -- azul petróleo
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent5', { fg = '#2f3549', nocombine = true }) -- azul neutro
    vim.api.nvim_set_hl(0, 'IndentBlanklineIndent6', { fg = '#3c445c', nocombine = true }) -- azul escuro

    -- Hooks e escopo
    local hooks = require('ibl.hooks')

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.cmd([[
        hi! link IblScope Normal
        hi! link IblWhitespace NonText
      ]])
    end)

    ibl.setup({
      indent = {
        char = '┊',
        tab_char = '┊',
        highlight = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
        smart_indent_cap = true,
      },

      whitespace = {
        remove_blankline_trail = true,
      },

      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        include = {
          node_type = {
            lua = {
              'chunk',
              'do_statement',
              'table_constructor',
            },

            python = {
              'module',
              'function_definition',
              'class_definition',
            },

            typescript = {
              'function',
              'method',
              'class_body',
              'object',
            },

            json = {
              'object',
              'array',
            },

            go = {
              'function_declaration',
              'method_declaration',
              'if_statement',
              'for_statement',
              'switch_statement',
              'select_statement',
              'composite_literal',
              'block',
            },

            php = {
              'namespace_definition',
              'function_definition',
              'method_declaration',
              'class_declaration',
              'interface_declaration',
              'trait_declaration',
              'if_statement',
              'foreach_statement',
              'for_statement',
              'while_statement',
              'switch_statement',
              'block',
            },

            yaml = {
              'block_mapping_pair',
              'block_sequence_item',
              'sequence_node',
              'mapping_node',
            },
          },
        },
      },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
        buftypes = {
          'terminal',
          'nofile',
          'quickfix',
          'prompt',
        },
      },
    })
  end,
}
