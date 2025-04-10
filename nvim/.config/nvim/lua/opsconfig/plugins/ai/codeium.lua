return {
  -- NOTE:  Autocompletar código com IA no Neovim.
  --  Sugestões em tempo real para diversas linguagens de programação.
  --  Acelera o desenvolvimento com previsões contextuais e inteligentes.
  --  Configurável, com suporte a atalhos e preferências personalizadas.
  --  Repositório: https://github.com/Exafunction/windsurf.vim
  'Exafunction/windsurf.vim',

  enabled = vim.g.opsconfig.plugins.windsurf_vim and vim.g.opsconfig.plugins.plenary_nvim and vim.g.opsconfig.plugins.nvim_cmp,

  dependencies = {
    -- NOTE:  Biblioteca auxiliar com funções utilitárias para desenvolvimento em Lua no Neovim.
    --  Fornece manipulação de arquivos, async, paths, jobs e mais.
    --  Dependência essencial para diversos plugins, como Telescope e nvim-lint.
    --  Facilita desenvolvimento de plugins com API unificada e eficiente.
    --  Repositório: https://github.com/nvim-lua/plenary.nvim
    {
      'nvim-lua/plenary.nvim',
      enabled = true,
    },

    -- NOTE:  Autocompletar poderoso e extensível para Neovim.
    --  Suporte a múltiplas fontes, incluindo LSP, buffers e snippets.
    --  Integra-se com luasnip, nvim-autopairs e outros plugins.
    --  Altamente configurável, com mapeamentos e comportamento personalizável.
    --  Repositório: https://github.com/hrsh7th/nvim-cmp
    {
      'hrsh7th/nvim-cmp',
      enabled = true,
    },
  },

  event = 'BufEnter',

  branch = 'main',

  opt = {
    enable_cmp_source = true,
    codeium_filetypes = {
      yaml = false,
      json = false,
      toml = false,
      markdown = false,
      help = false,
      nerdtree = false,
      NvimTree = false,
      telescope = false,
      TelescopePrompt = false,
      fzf = false,
      gitcommit = true,
      gitrebase = true,
    },

    virtual_text = {
      enabled = true,

      -- Set to true if you never want completions to be shown automatically.
      manual = false,

      -- A mapping of filetype to true or false, to enable virtual text.
      filetypes = {},

      -- Whether to enable virtual text of not for filetypes not specifically listed above.
      default_filetype_enabled = true,

      -- How long to wait (in ms) before requesting completions after typing stops.
      idle_delay = 75,

      -- Priority of the virtual text. This usually ensures that the completions appear on top of
      -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if desired.
      virtual_text_priority = 65535,

      -- Set to false to disable all key bindings for managing completions.
      map_keys = true,

      -- The key to press when hitting the accept keybinding but no completion is showing.
      -- Defaults to \t normally or <c-n> when a popup is showing.
      accept_fallback = nil,

      -- Key bindings for managing completions in virtual text mode.
      key_bindings = {
        -- Accept the current completion.
        accept = '<Tab>',
        -- Accept the next word.
        accept_word = false,
        -- Accept the next line.
        accept_line = false,
        -- Clear the virtual text.
        clear = false,
        -- Cycle to the next completion.
        next = '<M-]>',
        -- Cycle to the previous completion.
        prev = '<M-[>',
      },
    },
  },

  config = function()
    vim.g.codeium_filetypes = {
      yaml = false,
      json = false,
      toml = false,
      markdown = false,
      help = false,
      nerdtree = false,
      NvimTree = false,
      telescope = false,
      TelescopePrompt = false,
      fzf = false,
      gitcommit = true,
      gitrebase = true,
    }
  end,
}
