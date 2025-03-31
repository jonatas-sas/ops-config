return {
  -- NOTE:  Sistema de wiki pessoal no Neovim.
  --  Suporte a links, tabelas, diário e múltiplos formatos de markdown.
  --  Facilita a organização de notas, documentos e planejamento de projetos.
  --  Altamente configurável, com opções de sincronização e exportação.
  --  Repositório: https://github.com/vimwiki/vimwiki
  'vimwiki/vimwiki',

  enabled = vim.g.opsconfig.plugins.vimwiki and vim.g.opsconfig.plugins.taskwiki and vim.g.opsconfig.plugins.vim_markdown,

  cond = vim.g.opsconfig.global.tasks.enabled,

  event = 'VeryLazy',

  depends = {
    {
      -- NOTE:  Integra o Taskwarrior ao VimWiki no Neovim.
      --  Permite gerenciar tarefas diretamente dentro de páginas do VimWiki.
      --  Facilita o acompanhamento de prazos, prioridades e projetos.
      --  Configurável, com suporte a filtros, comandos personalizados e sincronização.
      --  Repositório: https://github.com/tbabej/taskwiki
      'tbabej/taskwiki',
      enabled = true,
    },
    {
      -- NOTE:  Suporte avançado a Markdown no Neovim.
      --  Realce de sintaxe, dobramento e atalhos para edição eficiente.
      --  Facilita a escrita e organização de documentos em Markdown.
      --  Configurável, com suporte a tabelas, listas e pré-visualização.
      --  Repositório: https://github.com/plasticboy/vim-markdown
      'plasticboy/vim-markdown',
      enabled = true,
    },
  },

  config = function()
    local project_root = vim.fn.getcwd()

    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_auto_chdir = 1
    vim.g.vimwiki_key_mappings = { global = 0 }

    vim.g.vimwiki_list = {
      {
        path = project_root .. '/projects',
        syntax = 'markdown',
        ext = '.md',
      },
    }

    vim.g.vimwiki_ext2syntax = {
      ['.md'] = 'markdown',
      ['.markdown'] = 'markdown',
      ['.mdown'] = 'markdown',
    }

    vim.g.taskwiki_list = {
      {
        path = project_root .. '/projects',
        syntax = 'markdown',
        ext = '.md',
      },
    }

    vim.g.taskwiki_markdown_syntax = 'markdown'

    vim.g.markdown_folding = 1
  end,
}
