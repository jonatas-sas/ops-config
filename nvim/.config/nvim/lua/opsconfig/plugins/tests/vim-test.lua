return {
  -- NOTE:   Framework para executar testes diretamente do Neovim.
  --   Suporte a diversas linguagens e frameworks de teste.
  --   Integra-se com terminais, Tmux, Neovim jobs e mais.
  --   Comandos fáceis para rodar testes de arquivo, linha ou suíte completa.
  --   Repositório: https://github.com/vim-test/vim-test
  'vim-test/vim-test',
  enabled = vim.g.opsconfig.plugins.vim_test,

  dependencies = {
    {
      -- NOTE:   Plugin para interação entre Neovim/Vim e tmux.
      --   Permite enviar comandos do editor para um painel do tmux.
      --   Suporte a execução assíncrona de scripts e testes.
      --   Atalhos configuráveis para envio rápido de comandos ao tmux.
      --   Repositório: https://github.com/preservim/vimux
      'preservim/vimux',
      enabled = vim.g.opsconfig.plugins.vimux,
    },
  },
  config = function()
    vim.cmd([[
      let test#strategy = "vimux"
    ]])
  end,
}
