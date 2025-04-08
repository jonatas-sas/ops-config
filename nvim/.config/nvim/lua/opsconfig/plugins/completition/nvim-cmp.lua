return {
  -- NOTE:  Autocompletar poderoso e extensível para Neovim.
  --  Suporte a múltiplas fontes, incluindo LSP, buffers e snippets.
  --  Integra-se com luasnip, nvim-autopairs e outros plugins.
  --  Altamente configurável, com mapeamentos e comportamento personalizável.
  --  Repositório: https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',

  enabled = vim.g.opsconfig.plugins.nvim_cmp,

  event = 'InsertEnter',

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Fonte de autocompletar para palavras do buffer no nvim-cmp.
    --  Sugere trechos de texto já escritos no arquivo atual.
    --  Personalizável, permitindo filtros e preferências de correspondência.
    --  Leve e otimizado para eficiência no Neovim.
    --  Repositório: https://github.com/hrsh7th/cmp-buffer
    {
      'hrsh7th/cmp-buffer',
      enabled = true,
    },

    -- NOTE: ﱮ Fonte de autocompletar para caminhos de arquivos no nvim-cmp.
    --  Sugere diretórios e arquivos com base no caminho digitado.
    --  Suporte a caminhos absolutos e relativos no Neovim.
    --  Leve, rápido e fácil de configurar.
    --  Repositório: https://github.com/hrsh7th/cmp-path
    {
      'hrsh7th/cmp-path',
      enabled = true,
    },

    -- NOTE:   Fonte de autocompletar para a linha de comando do Neovim.
    --   Fornece sugestões enquanto digita comandos no modo de comando (`:`).
    --   Integra-se com nvim-cmp para um fluxo de trabalho mais rápido e fluído.
    --   Suporte a argumentos de comandos e histórico de entradas anteriores.
    --   Repositório: https://github.com/hrsh7th/cmp-cmdline
    {
      'hrsh7th/cmp-cmdline',
      enabled = true,
    },

    -- NOTE:  Fonte de autocompletar para LSP no nvim-cmp.
    --  Fornece sugestões inteligentes baseadas em servidores LSP ativos.
    --  Suporte para snippets, assinaturas de funções e documentação inline.
    --  Essencial para integração entre nvim-cmp e Neovim LSP.
    --  Repositório: https://github.com/hrsh7th/cmp-nvim-lsp
    {
      'hrsh7th/cmp-nvim-lsp',
      enabled = vim.g.opsconfig.plugins.cmp_nvim_lsp,
    },

    -- NOTE:  Fonte de autocompletar para LuaSnip no nvim-cmp.
    --  Permite expandir e navegar por snippets diretamente no completor.
    --  Suporte a placeholders dinâmicos e múltiplas expansões.
    --  Integração fluida com LuaSnip para uma experiência otimizada.
    --  Repositório: https://github.com/saadparwaiz1/cmp_luasnip
    {
      'saadparwaiz1/cmp_luasnip',
      enabled = vim.g.opsconfig.plugins.cmp_luasnip,
    },

    -- NOTE:  Adiciona ícones aos menus de autocompletar do nvim-cmp.
    --  Melhora a experiência visual com ícones para LSP, snippets e buffers.
    --  Suporte a personalização de ícones e formatação do menu.
    --  Leve, eficiente e fácil de integrar com nvim-cmp.
    --  Repositório: https://github.com/onsails/lspkind.nvim
    {
      'onsails/lspkind.nvim',
      enabled = vim.g.opsconfig.plugins.lspkind_nvim,
    },

    -- NOTE:  Integra o GitHub Copilot ao nvim-cmp.
    --  Permite usar sugestões do Copilot como fonte de autocomplete.
    --  Melhora a experiência de código com previsões mais naturais e fluídas.
    --  Totalmente configurável, com suporte a prioridades e ajustes finos.
    --  Repositório: https://github.com/zbirenbaum/copilot-cmp
    {
      'zbirenbaum/copilot-cmp',
      enabled = vim.g.opsconfig.plugins.copilot_cmp,
    },
  },

  -- }}}

  config = function()
    local cmp = require('cmp')
    local setup = {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },

      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        expandable_indicator = true,
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
      }),
    }

    local sources = {}

    if vim.g.opsconfig.plugins.luasnip then
      local luasnip = require('luasnip')

      setup.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      table.insert(sources, { name = 'luasnip' })
    end

    if vim.g.opsconfig.plugins.lspkind_nvim then
      local lspkind = require('lspkind')

      setup.formatting.format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        menu = {
          buffer = '[Buf]',
          nvim_lsp = '[LSP]',
          luasnip = '[Snip]',
          path = '[Path]',
          codium = '[Codeium]',
          copilot = '[Copilot]',
          cmdline = '[CMD]',
          nvim_lua = '[NeoVim]',
        },
        symbol_map = {
          Class = 'ﴯ',
          Function = '',
          Method = '',
          Property = '',
          Field = '',
          Text = '',
          Constructor = '',
          Variable = '',
          Interface = '',
          Module = '',
          Unit = '',
          Value = '󰎠',
          Enum = '',
          Keyword = '',
          Snippet = '',
          Color = '',
          File = '',
          Reference = '',
          Folder = '',
          EnumMember = '',
          Constant = '',
          Struct = '',
          Event = '',
          Operator = '',
          TypeParameter = '',
        },
        ellipsis_char = '...',
        show_labelDetails = true,
        window = {
          completion = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
          },
          documentation = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
          },
        },
      })
    end

    table.insert(sources, { name = 'nvim_lsp' })
    table.insert(sources, { name = 'buffer' })
    table.insert(sources, { name = 'path' })
    table.insert(sources, { name = 'cmdline' })

    if vim.g.opsconfig.plugins.copilot_cmp then
      table.insert(sources, { name = 'copilot' })
    end

    if vim.g.opsconfig.plugins.codeium_vim then
      table.insert(sources, { name = 'codeium' })
    end

    table.insert(sources, { name = 'nvim_lua' })

    setup.sources = cmp.config.sources(sources)

    cmp.setup(setup)
  end,
}
