return {
  -- NOTE:  Coleção de configurações prontas para servidores LSP no Neovim.
  --  Facilita a configuração e gerenciamento de LSPs com opções personalizáveis.
  --  Integra-se com mason.nvim para instalação automática de servidores.
  --  Repositório: https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',

  enabled = vim.g.opsconfig.plugins.nvim_lspconfig
    and vim.g.opsconfig.plugins.mason_nvim
    and vim.g.opsconfig.plugins.mason_lspconfig_nvim
    and vim.g.opsconfig.plugins.nvim_ufo,

  dependencies = {
    { 'williamboman/mason.nvim', enabled = true },
    { 'williamboman/mason-lspconfig.nvim', enabled = true },
    { 'kevinhwang91/nvim-ufo', enabled = true },
  },

  config = function()
    local lspconfig = require('lspconfig')

    -- LSP Config {{{

    -- NOTE: LSP servers and clients are able to communicate to each other what features they support.
    -- By default, Neovim doesn't support everything that is in the LSP specification.
    -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local flags = {
      debounce_text_changes = 100,
    }

    local config = {
      flags = flags,
      capabilities = capabilities,
    }

    -- Lua LSP {{{

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },

          diagnostics = {
            globals = { 'vim' },
          },

          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },

          telemetry = {
            enable = false,
          },

          hint = {
            enable = true,
            arrayIndex = 'Disable',
            paramName = 'All',
            paramType = true,
          },
        },
      },

      flags = flags,

      capabilities = capabilities,
    })

    -- }}}

    -- Go LSP {{{

    lspconfig.gopls.setup({
      cmd = { 'gopls' },

      settings = {
        gopls = {
          usePlaceholders = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    -- }}}

    -- PHP LSPs {{{

    -- Phpactor {{{

    if vim.g.opsconfig.global.languages.php.phpactor then
      lspconfig.phpactor.setup({
        cmd = { 'phpactor', 'language-server' },

        filetypes = { 'php' },

        root_dir = lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.json', '.phpactor.yml'),

        flags = {
          debounce_text_changes = 150,
        },

        settings = {
          phpactor = {
            completion = {
              enable = true,
            },

            indexing = {
              exclude = {
                'node_modules',
                'storage',
                'runtime',
                'cache',
                'tests',
                'tmp',
                'temp',
              },
            },

            diagnostics = {
              enable = true,
            },

            inlay_hints = {
              enable = true,
            },

            lsp = {
              enabled = true,
              completion = true,
              code_lens = true,
              hover = true,
              rename = true,
              folding = true,
            },
          },
        },
      })
    end

    -- }}}

    -- Intelephense {{{

    if vim.g.opsconfig.global.languages.php.intelephense then
      local intelephense_key = os.getenv('OPSCONFIG_INTELEPHENSE_KEY') or ''

      lspconfig.intelephense.setup({
        cmd = { 'intelephense', '--stdio' },
        init_options = {
          licenceKey = intelephense_key,
        },
        settings = {
          intelephense = {
            stubs = {
              'bcmath',
              'bz2',
              'Core',
              'curl',
              'date',
              'dom',
              'fileinfo',
              'filter',
              'gd',
              'json',
              'libxml',
              'mbstring',
              'mysqli',
              'openssl',
              'pcntl',
              'pcre',
              'PDO',
              'pdo_mysql',
              'readline',
              'Reflection',
              'session',
              'SimpleXML',
              'sockets',
              'sodium',
              'SPL',
              'standard',
              'tokenizer',
              'xml',
              'zip',
              'zlib',
              'wordpress',
              'woocommerce',
              'phpunit',
              'composer',
            },

            environment = {
              includePaths = { 'vendor' },
            },

            format = {
              enable = false,
            },

            files = {
              maxSize = 5000000,
              exclude = {
                '**/node_modules/**',
                '**/.git/**',
                '**/storage/**',
                '**/cache/**',
                '**/runtime/**',
              },
            },

            diagnostics = {
              enable = true,
            },

            completion = {
              fullyQualifyGlobalConstants = true,
              insertUseDeclaration = true,
              triggerParameterHints = true,
              maxItems = 100,
            },

            indexing = {
              exclude = {
                '**/node_modules/**',
                '**/.git/**',
                '**/storage/**',
                '**/cache/**',
                '**/runtime/**',
              },
            },
          },
        },

        flags = flags,

        capabilities = capabilities,
      })
    end

    -- }}}

    -- }}}

    -- Other LSPs {{{

    lspconfig.bashls.setup(config)

    lspconfig.cssls.setup(config)

    lspconfig.html.setup(config)

    lspconfig.jsonls.setup(config)

    lspconfig.marksman.setup(config)

    lspconfig.pyright.setup(config)

    lspconfig.eslint.setup({
      flags = flags,
      capabilities = capabilities,
      root_dir = require('lspconfig.util').root_pattern(
        'eslint.config.mjs',
        'eslint.config.js',
        'package.json',
        '.git'
      ),
      settings = {
        experimental = {
          enableCodeLens = true,
          useFlatConfig = true,
        },
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = 'line',
          },
          showDocumentation = {
            enable = true,
          },
        },
      },
    })

    lspconfig.tsp_server.setup({
      flags = flags,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayVariableTypeHints = true,
          },
        },
      },
    })

    -- }}}

    -- }}}

    -- Diagnostic Config {{{

    local diagnostic_config = {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    if vim.g.opsconfig.global.fonts.nerd_font_available then
      local signs = {
        ERROR = '',
        WARN = '',
        INFO = '',
        HINT = '',
      }

      local diagnostic_signs = {}

      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end

      diagnostic_config.signs = { text = diagnostic_signs }
    end

    vim.diagnostic.config(diagnostic_config)

    -- }}}

    -- Inlay Hints and Client Actions {{{

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('opsconfig-lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Inlay Hints {{{

        if client and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        -- }}}

        -- Client Actions {{{

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client then
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('opsconfig-lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('opsconfig-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'opsconfig-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          client.handlers['textDocument/hover'] = function(_, result, _, _)
            local bufnr, winnr = vim.lsp.util.open_floating_preview(result and result.contents or {}, 'markdown', {
              border = 'rounded',
              focusable = false,
              style = 'minimal',
              relative = 'cursor',
              width = 60,
              max_width = 80,
              max_height = 20,
            })

            if winnr then
              vim.api.nvim_win_set_option(winnr, 'winhighlight', 'Normal:NormalFloat,FloatBorder:FloatBorder')
            end

            return bufnr, winnr
          end

          vim.cmd([[
  hi NormalFloat guibg=#1e1e2e
  hi FloatBorder guibg=#1e1e2e guifg=#89b4fa
]])
        end

        -- }}}
      end,
    })

    -- }}}

    -- Keymaps {{{
    vim.keymap.set('n', '<leader>bc', function()
      local current = vim.api.nvim_get_current_buf()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
      vim.cmd('LspStop')
      vim.cmd('LspStart')
    end, { desc = 'Close other buffers and restart LSP' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('opsconfig-lsp-keymaps', { clear = true }),
      callback = function(event)
        local buffer = event.buf
        local wk = require('which-key')

        wk.add({
          { 'g', group = '󰘧 Goto', icon = '' },
          {
            'gd',
            vim.lsp.buf.definition,
            desc = 'Go to Definition',
            icon = { color = 'blue', icon = '󰙰' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            'gD',
            vim.lsp.buf.declaration,
            desc = 'Go to Declaration',
            icon = { color = 'yellow', icon = '󰙯' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            'gr',
            vim.lsp.buf.references,
            desc = 'Find References',
            icon = { color = 'green', icon = '󰆿' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            'gI',
            vim.lsp.buf.implementation,
            desc = 'Go to Implementation',
            icon = { color = 'cyan', icon = '󰉺' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>l',
            group = ' LSP',
            icon = '',
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lD',
            vim.lsp.buf.type_definition,
            desc = 'Type Definition',
            icon = { color = 'yellow', icon = '󰉼' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>le',
            vim.diagnostic.open_float,
            desc = 'Show Error',
            icon = { color = 'red', icon = '󰗖' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lrn',
            vim.lsp.buf.rename,
            desc = 'Rename Symbol',
            icon = { color = 'orange', icon = '󰑕' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lca',
            vim.lsp.buf.code_action,
            desc = 'Code Action',
            icon = { color = 'green', icon = '󰨇' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lws',
            vim.lsp.buf.workspace_symbol,
            desc = 'Workspace Symbols',
            icon = { color = 'purple', icon = '󰓥' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lds',
            vim.lsp.buf.document_symbol,
            desc = 'Document Symbols',
            icon = { color = 'blue', icon = '󰙰' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lF',
            function()
              vim.lsp.buf.format({ async = true })
            end,
            desc = 'Format Code',
            icon = { color = 'cyan', icon = '󰛢' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lcl',
            vim.lsp.codelens.run,
            desc = 'Run CodeLens',
            icon = { color = 'yellow', icon = '󰘨' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lcL',
            vim.lsp.codelens.refresh,
            desc = 'Refresh CodeLens',
            icon = { color = 'green', icon = '󰘩' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>lih',
            function()
              vim.lsp.inlay_hint.enable(buffer, not vim.lsp.inlay_hint.is_enabled(buffer))
            end,
            desc = 'Toggle Inlay Hints',
            icon = { color = 'blue', icon = '󰈅' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>t',
            group = '󰭯 Telescope',
            icon = '',
          },
          {
            '<leader>td',
            require('telescope.builtin').lsp_definitions,
            desc = 'Telescope Definitions',
            icon = { color = 'blue', icon = '󰙰' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>tr',
            require('telescope.builtin').lsp_references,
            desc = 'Telescope References',
            icon = { color = 'green', icon = '󰆿' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>ti',
            require('telescope.builtin').lsp_implementations,
            desc = 'Telescope Implementations',
            icon = { color = 'cyan', icon = '󰉺' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>ts',
            require('telescope.builtin').lsp_document_symbols,
            desc = 'Telescope Document Symbols',
            icon = { color = 'purple', icon = '󰙰' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>tS',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            desc = 'Telescope Workspace Symbols',
            icon = { color = 'orange', icon = '󰓥' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
          {
            '<leader>tdi',
            require('telescope.builtin').diagnostics,
            desc = 'Telescope Diagnostics',
            icon = { color = 'red', icon = '󰗖' },
            buffer = buffer,
            noremap = true,
            silent = true,
          },
        })
      end,
    })
    -- }}}
  end,
}
