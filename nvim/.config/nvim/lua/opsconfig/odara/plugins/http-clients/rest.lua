return {
  -- NOTE:  Cliente HTTP para Neovim com suporte a requisições assíncronas.
  --  Permite enviar requisições diretamente do editor e visualizar respostas.
  --  Integra-se com curl e exibe respostas formatadas no buffer.
  --  Suporte a autenticação, headers e corpo de requisição configuráveis.
  --  Repositório: https://github.com/rest-nvim/rest.nvim
  'rest-nvim/rest.nvim',

  enabled = vim.g.opsconfig.plugins.rest_nvim and vim.g.opsconfig.plugins.plenary_nvim,

  -- dependencies {{{

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

    -- NOTE: 墳 Barra de status altamente customizável para Neovim.
    --  Suporte a separadores, temas e integração com LSP, buffers e git.
    --  Leve e otimizada para desempenho sem comprometer a estética.
    --  Fácil de configurar e compatível com nvim-web-devicons.
    --  Repositório: https://github.com/nvim-lualine/lualine.nvim
    {
      'nvim-lualine/lualine.nvim',
      enabled = vim.g.opsconfig.plugins.lualine_nvim,
    },

    -- NOTE:  Fuzzy finder altamente extensível para Neovim.
    --  Busca rápida em arquivos, buffers, LSP, comandos e muito mais.
    --  Integra-se com ripgrep, fd, fzf e plugins externos.
    --  Altamente configurável e personalizável com atalhos e extensões.
    --  Repositório: https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
      enabled = vim.g.opsconfig.plugins.telescope_nvim,
    },
  },

  -- }}}

  ft = { 'http' },

  config = function()
    local rest = require('rest-nvim')

    local function urlencode(str)
      if not str then
        return ''
      end
      str = str:gsub('\n', '\r\n')
      str = str:gsub('([^%w %-%_%.%~])', function(c)
        return string.format('%%%02X', string.byte(c))
      end)
      str = str:gsub(' ', '+') -- Substituir espaço por +
      return str
    end

    rest.setup({
      http_client = 'httpie',
      custom_dynamic_variables = {},
      request = {
        skip_ssl_verification = true,
        hooks = {
          encode_url = true,
          user_agent = 'rest.nvim v' .. require('rest-nvim.api').VERSION,
          set_content_type = true,
        },
      },
      response = {
        hooks = {
          decode_url = true,
          format = true,
        },
      },
      clients = {
        curl = {
          statistics = {
            { id = 'time_total', winbar = 'take', title = 'Time taken' },
            { id = 'size_download', winbar = 'size', title = 'Download size' },
          },
          opts = {
            set_compressed = false,
          },
        },
      },
      cookies = {
        enable = true,
        path = vim.fs.joinpath(vim.fn.stdpath('data') --[[@as string]], 'rest-nvim.cookies'),
      },
      env = {
        enable = true,
        pattern = '.*%.env.*',
      },
      ui = {
        winbar = true,
        keybinds = {
          prev = 'H',
          next = 'L',
        },
      },
      highlight = {
        enable = true,
        timeout = 750,
      },
      _log_level = vim.log.levels.WARN,
      before_run = function(_, req)
        if req.headers['Content-Type'] == 'application/x-www-form-urlencoded' then
          req.body = urlencode(req.body)
        end
      end,
    })

    if vim.g.opsconfig.plugins.telescope_nvim then
      require('telescope').load_extension('rest')
    end

    -- 🔥 Integração com Lualine (Mostra status da última requisição)
    if vim.g.opsconfig.plugins.lualine_nvim then
      local function rest_status()
        return vim.g.rest_last_http_status or 'No Request'
      end

      require('lualine').setup({
        sections = {
          lualine_x = { rest_status },
        },
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'RestNvimResponse',
        callback = function()
          local json = vim.fn.json_decode(vim.g.rest_last_response or '{}')
          if json and json.status then
            vim.g.rest_last_http_status = 'HTTP ' .. json.status
          end
        end,
      })
    end

    -- 🔥 Atalhos com `desc` para integração com `which-key`
    vim.keymap.set('n', '<leader>rr', ':Rest run<CR>', { desc = '[R]un HTTP [R]equest' })
    vim.keymap.set('n', '<leader>rl', ':Rest last<CR>', { desc = '[R]un [L]ast Request' })
    vim.keymap.set('n', '<leader>rh', ':Telescope rest<CR>', { desc = 'HTTP [R]equest [H]istory' })
  end,
}
