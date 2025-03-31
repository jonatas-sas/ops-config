return {
  -- NOTE:  Navegação fluida entre janelas do Neovim e painéis do tmux.
  --  Usa atalhos intuitivos para alternar entre splits e tmux panes.
  --  Funciona sem necessidade de configuração extra no tmux.
  --  Leve e sem impacto no desempenho do Neovim.
  --  Repositório: https://github.com/christoomey/vim-tmux-navigator
  'christoomey/vim-tmux-navigator',

  enabled = vim.g.opsconfig.plugins.vim_tmux_navigator or false,

  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },

  keys = {
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
}
