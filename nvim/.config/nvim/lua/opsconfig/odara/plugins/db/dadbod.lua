return {
  -- NOTE:  Interface gráfica para o vim-dadbod no Neovim.
  --  Fornece um explorador de bancos de dados interativo.
  --  Permite navegar entre tabelas, visualizar esquemas e executar queries.
  --  Requer vim-dadbod como dependência.
  --  Repositório: https://github.com/kristijanhusak/vim-dadbod-ui
  'kristijanhusak/vim-dadbod-ui',

  enabled = vim.g.opsconfig.plugins.vim_dadbod_ui,

  dependencies = {
    -- NOTE:  Plugin para gerenciamento de bancos de dados no Neovim.
    --  Permite executar queries SQL diretamente no editor.
    --  Suporte para MySQL, PostgreSQL, SQLite, entre outros.
    --  Integração com plugins como vim-dadbod-ui e vim-dadbod-completion.
    --  Repositório: https://github.com/tpope/vim-dadbod
    {
      'tpope/vim-dadbod',
      enabled = true,
      lazy = true,
    },

    -- NOTE:  Autocompletar SQL para vim-dadbod no Neovim.
    --  Oferece sugestões de tabelas, colunas e comandos SQL.
    --  Suporte para MySQL, PostgreSQL, SQLite e outros bancos.
    --  Funciona com nvim-cmp e outras engines de autocompletar.
    --  Repositório: https://github.com/kristijanhusak/vim-dadbod-completion
    {
      'kristijanhusak/vim-dadbod-completion',
      enabled = true,
      lazy = true,
      ft = { 'sql', 'mysql', 'plsql' },
    },
  },

  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },

  init = function()
    vim.g.db_ui_use_nerd_fonts = vim.g.opsconfig.global.fonts.nerd_font_available and 1 or 0
  end,
}
