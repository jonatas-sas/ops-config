return {
  -- NOTE:  Realça e gerencia comentários como TODO, FIX, HACK e outros no código.
  --  Integra-se com Telescope para busca e navegação rápida.
  --  Suporte a destaque visual e personalização de palavras-chave.
  --  Repositório: https://github.com/folke/todo-comments.nvim
  'folke/todo-comments.nvim',

  enabled = vim.g.opsconfig.plugins.todo_comments_nvim,

  event = {
    'BufReadPre',
    'BufNewFile',
  },

  dependencies = {
    {
      'nvim-lua/plenary.nvim',
      enabled = true,
    },
  },

  config = function()
    local todo_comments = require('todo-comments')

    local keymap = vim.keymap

    todo_comments.setup({
      signs = true,
      sign_priority = 8,
      merge_keywords = true,

      keywords = {
        FIX = {
          icon = ' ',
          color = 'error',
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
        },

        TODO = {
          icon = ' ',
          color = 'info',
        },

        SECTION = {
          icon = '󰆦 ',
          color = 'section',
          alt = { 'GROUP' },
        },

        SUBSECTION = {
          icon = '󰆦 ',
          color = 'subsection',
          alt = { 'SUBGROUP' },
        },

        HACK = {
          icon = ' ',
          color = 'warning',
        },

        WARN = {
          icon = ' ',
          color = 'warning',
          alt = { 'WARNING' },
        },

        PERF = {
          icon = ' ',
          alt = { 'PERFORMANCE', 'OPTIMIZE' },
        },

        NOTE = {
          icon = ' ',
          color = 'hint',
          alt = { 'INFO' },
        },

        TEST = {
          icon = ' ',
          color = 'test',
          alt = { 'TESTING', 'PASSED', 'FAILED' },
        },

        HELP = {
          icon = ' ',
          color = 'info',
        },
      },

      gui_style = {
        fg = 'NONE',
        bg = 'BOLD',
      },

      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- "fg" or "bg" or empty
        keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = 'fg', -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },

      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = {
          'DiagnosticError',
          'ErrorMsg',
          '#DC2626',
        },

        warning = {
          'DiagnosticWarn',
          'WarningMsg',
          '#FBBF24',
        },

        info = {
          'DiagnosticInfo',
          '#2563EB',
        },

        hint = {
          'DiagnosticHint',
          '#10B981',
        },

        default = {
          'Identifier',
          '#7C3AED',
        },

        test = {
          'Identifier',
          '#FF00FF',
        },

        section = {
          '#a674fc',
        },

        subsection = {
          '#db9eff',
        },
      },
    })

    keymap.set('n', ']t', function()
      todo_comments.jump_next()
    end, { desc = 'Next todo comment' })

    keymap.set('n', '[t', function()
      todo_comments.jump_prev()
    end, { desc = 'Previous todo comment' })
  end,
}
