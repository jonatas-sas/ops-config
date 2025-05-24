return {
  {
    'ojroques/nvim-osc52',

    event = 'VeryLazy',

    config = function()
      local osc52 = require('osc52')

      osc52.setup({
        trim = false,
        tmux_passthrough = true,
      })

      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
            osc52.copy_register('"')
          end
        end,
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',

    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },

    config = function()
      local nvimtree = require('nvim-tree')

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup({
        respect_buf_cwd = true,
        sync_root_with_cwd = true,

        view = {
          side = 'left',
          width = 60,
          relativenumber = false,
          cursorline = true,
          preserve_window_proportions = true,
        },

        update_focused_file = {
          enable = true,
          update_root = false,
          update_cwd = true,
          ignore_list = {},
        },

        renderer = {
          highlight_git = true,
          highlight_opened_files = 'all',
          root_folder_label = false,
          symlink_destination = false,

          indent_markers = {
            enable = false,
          },

          icons = {
            git_placement = 'after',
            webdev_colors = true,
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },

            glyphs = {
              default = '',
              symlink = '',
              folder = {
                arrow_closed = '   ',
                arrow_open = '   ',
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
                symlink_open = '',
              },
              git = {
                unstaged = '',
                staged = '',
                unmerged = '',
                renamed = '➜',
                untracked = '',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },

        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,
            },
          },
        },

        git = {
          enable = true,
          ignore = false,
          timeout = 10000,
        },

        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
          vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        end,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',

    config = function()
      require('fidget').setup({
        progress = {
          poll_rate = 100,
          suppress_on_insert = false,
          ignore_done_already = false,
          ignore_empty_message = false,
          clear_on_detach = function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
          notification_group = function(msg)
            return msg.lsp_client.name
          end,
          ignore = {},
          display = {
            render_limit = 16,
            done_ttl = 3,
            done_icon = '✔',
            done_style = 'Constant',
            progress_ttl = 60,
            progress_icon = { 'dots' },
            progress_style = 'WarningMsg',
            group_style = 'Title',
            icon_style = 'Question',
            priority = 30,
            skip_history = true,
            format_message = require('fidget.progress.display').default_format_message,
            format_annote = function(msg)
              return msg.title
            end,
            format_group_name = function(group)
              return tostring(group)
            end,
            overrides = {
              rust_analyzer = { name = 'rust-analyzer' },
            },
          },

          lsp = {
            progress_ringbuf_size = 0,
            log_handler = false,
          },
        },

        notification = {
          poll_rate = 10,
          filter = vim.log.levels.INFO,
          history_size = 128,
          override_vim_notify = true,
          configs = {
            default = require('fidget.notification').default_config,
          },
          redirect = function(msg, level, opts)
            if opts and opts.on_open then
              return require('fidget.integration.nvim-notify').delegate(msg, level, opts)
            end
          end,

          view = {
            stack_upwards = true,
            icon_separator = ' ',
            group_separator = '---',
            group_separator_hl = 'Comment',
            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format('(%dx) %s', cnt, msg)
            end,
          },

          window = {
            normal_hl = 'Comment',
            winblend = 10,
            border = 'rounded',
            zindex = 45,
            max_width = 100,
            max_height = 8,
            align = 'bottom',
            relative = 'editor',
            x_padding = 1,
            y_padding = 0,
          },
        },

        integration = {
          ['nvim-tree'] = {
            enable = true,
          },
          ['xcodebuild-nvim'] = {
            enable = true,
          },
        },

        logger = {
          level = vim.log.levels.WARN,
          max_size = 10000,
          float_precision = 0.01,
          path = string.format('%s/fidget.nvim.log', vim.fn.stdpath('cache')),
        },
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',

    enabled = true,

    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },

    opts = {},
  },
  {
    'nvim-lua/plenary.nvim',

    enabled = true,
  },
  {
    'hrsh7th/nvim-cmp',

    event = 'InsertEnter',

    enabled = true,

    dependencies = {
      { 'hrsh7th/cmp-buffer', enabled = true },
      { 'hrsh7th/cmp-path', enabled = true },
      { 'hrsh7th/cmp-cmdline', enabled = true },
      { 'onsails/lspkind.nvim', enabled = true },
    },

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

      local lspkind = require('lspkind')

      setup.formatting.format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        menu = {
          buffer = '[Buf]',
          nvim_lsp = '[LSP]',
          luasnip = '[Snip]',
          path = '[Path]',
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
          Copilot = '',
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

      table.insert(sources, { name = 'nvim_lsp' })
      table.insert(sources, { name = 'buffer' })
      table.insert(sources, { name = 'path' })
      table.insert(sources, { name = 'nvim_lua' })

      setup.sources = cmp.config.sources(sources)

      cmp.setup(setup)
    end,
  },
  {
    'folke/lazydev.nvim',

    ft = 'lua',

    opts = {
      library = {
        {
          path = '${3rd}/luv/library',
          words = {
            'vim%.uv',
          },
        },
        {
          path = 'lazy.nvim',
          words = {
            'LazyVim',
          },
        },
      },
    },
  },
  {
    'antoinemadec/FixCursorHold.nvim',

    enabled = true,

    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
  {
    'catppuccin/nvim',

    name = 'catppuccin',

    enabled = true,

    priority = 1000,

    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'mocha',
          dark = 'mocha',
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          alpha = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          fidget = true,
          harpoon = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          which_key = true,
          markdown = true,
          noice = true,
          copilot_vim = false,
          dap = false,
          dap_ui = false,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
              ok = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
              ok = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          lsp_trouble = true,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      vim.cmd('colorscheme catppuccin')
    end,
  },
  {
    'williamboman/mason.nvim',

    enabled = true,

    dependencies = {
      { 'neovim/nvim-lspconfig', enabled = true },
      { 'williamboman/mason-lspconfig.nvim', enabled = true },
      { 'nvimtools/none-ls.nvim', enabled = true },
      { 'jay-babu/mason-null-ls.nvim', enabled = true },
    },

    config = function()
      local mason = require('mason')

      mason.setup()

      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'jsonls',
          'yamlls',
        },
        automatic_installation = true,
        automatic_enable = true,
      })

      local mason_null_ls = require('mason-null-ls')

      mason_null_ls.setup({
        ensure_installed = {
          'stylua',
          'prettier',
          'shfmt',
          'systemd_analyze',
          'jq',
        },
        automatic_installation = true,
      })
    end,
  },
  {
    'goolord/alpha-nvim',

    event = 'VimEnter',

    enabled = true,

    dependencies = {
      { 'nvim-lua/plenary.nvim', enabled = true },
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },

    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('e', '  > New File', '<cmd>ene<CR>'),
        dashboard.button('SPC ee', '  > File Explorer', '<cmd>NvimTreeToggle<CR>'),
        dashboard.button('SPC wr', '󰁯  > Restore Session', '<cmd>SessionRestore<CR>'),
        dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
      }

      alpha.setup(dashboard.opts)

      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',

    enabled = true,

    config = function()
      require('nvim-web-devicons').setup({
        override = {
          nginx = {
            icon = '',
            color = '#009639',
            name = 'Nginx',
          },

          ['*.nginx'] = {
            icon = '',
            color = '#009639',
            name = 'NginxCustom',
          },
        },
      })
    end,
  },
  {
    'stevearc/dressing.nvim',

    enabled = true,

    event = 'VeryLazy',
  },
  {
    'lukas-reineke/indent-blankline.nvim',

    enabled = true,

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
  },
  {
    'folke/noice.nvim',

    enabled = true,

    event = 'VeryLazy',

    opts = {},

    dependencies = {
      { 'MunifTanjim/nui.nvim', enabled = true },
      { 'rcarriga/nvim-notify', enabled = true },
    },

    config = function()
      require('noice').setup({
        cmdline = {
          enabled = true, -- enables the Noice cmdline UI
          view = 'cmdline_popup', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
          opts = {}, -- global options for the cmdline. See section on views
          format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = '^:', icon = '', lang = 'vim' },
            search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
            search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
            filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
            lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
            help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
            input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
          },
        },
        messages = {
          -- NOTE: If you enable messages, then the cmdline is enabled automatically.
          -- This is a current Neovim limitation.
          enabled = true, -- enables the Noice messages UI
          view = 'notify', -- default view for messages
          view_error = 'notify', -- view for errors
          view_warn = 'notify', -- view for warnings
          view_history = 'messages', -- view for :messages
          view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
        },
        popupmenu = {
          enabled = true, -- enables the Noice popupmenu UI
          ---@type 'nui'|'cmp'
          backend = 'nui', -- backend to use to show regular cmdline completions
          kind_icons = {}, -- set to `false` to disable icons
        },
        redirect = {
          view = 'popup',
          filter = { event = 'msg_show' },
        },
        commands = {
          history = {
            view = 'split',
            opts = { enter = true, format = 'details' },
            filter = {
              any = {
                { event = 'notify' },
                { error = true },
                { warning = true },
                { event = 'msg_show', kind = { '' } },
                { event = 'lsp', kind = 'message' },
              },
            },
          },
          -- :Noice last
          last = {
            view = 'popup',
            opts = { enter = true, format = 'details' },
            filter = {
              any = {
                { event = 'notify' },
                { error = true },
                { warning = true },
                { event = 'msg_show', kind = { '' } },
                { event = 'lsp', kind = 'message' },
              },
            },
            filter_opts = { count = 1 },
          },
          -- :Noice errors
          errors = {
            -- options for the message history that you get with `:Noice`
            view = 'popup',
            opts = { enter = true, format = 'details' },
            filter = { error = true },
            filter_opts = { reverse = true },
          },
          all = {
            -- options for the message history that you get with `:Noice`
            view = 'split',
            opts = { enter = true, format = 'details' },
            filter = {},
          },
        },
        notify = {
          -- Noice can be used as `vim.notify` so you can route any notification like other messages
          -- Notification messages have their level and other properties set.
          -- event is always "notify" and kind can be any log level as a string
          -- The default routes will forward notifications to nvim-notify
          -- Benefit of using Noice for this is the routing and consistent history view
          enabled = true,
          view = 'notify',
        },
        lsp = {
          progress = {
            enabled = true,
            format = 'lsp_progress',
            format_done = 'lsp_progress_done',
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = 'mini',
          },
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = false,
            ['vim.lsp.util.stylize_markdown'] = false,
            ['cmp.entry.get_documentation'] = false,
          },
          hover = {
            enabled = true,
            silent = false, -- set to true to not show a message if hover is not available
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
              luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
              throttle = 50, -- Debounce lsp signature help request by 50ms
            },
            view = nil, -- when nil, use defaults from documentation
            opts = {}, -- merged with defaults from documentation
          },
          message = {
            enabled = true,
            view = 'notify',
            opts = {},
          },
          documentation = {
            view = 'hover',
            opts = {
              lang = 'markdown',
              replace = true,
              render = 'plain',
              format = { '{message}' },
              win_options = { concealcursor = 'n', conceallevel = 3 },
            },
          },
        },
        markdown = {
          hover = {
            ['|(%S-)|'] = vim.cmd.help, -- vim help links
            ['%[.-%]%((%S-)%)'] = require('noice.util').open, -- markdown links
          },
          highlights = {
            ['|%S-|'] = '@text.reference',
            ['@%S+'] = '@parameter',
            ['^%s*(Parameters:)'] = '@text.title',
            ['^%s*(Return:)'] = '@text.title',
            ['^%s*(See also:)'] = '@text.title',
            ['{%S-}'] = '@parameter',
          },
        },
        health = {
          checker = true, -- Disable if you don't want health checks to run
        },
        presets = {
          -- you can enable a preset by setting it to true, or a table that will override the preset config
          -- you can also add custom presets that you can enable/disable with enabled=true
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
        views = {}, ---@see section on views
        routes = {}, --- @see section on routes
        status = {}, --- @see section on statusline components
        format = {}, --- @see section on formatting
      })

      require('notify').setup({
        background_colour = require('catppuccin.palettes').get_palette('mocha').base,
      })
    end,
  },
  {
    'folke/which-key.nvim',

    enabled = true,

    event = 'VimEnter',

    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,

    opts = {
      delay = 0,

      icons = {
        mappings = false,

        keys = {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  {
    'stevearc/conform.nvim',

    enabled = true,

    event = {
      'BufWritePre',
    },

    config = function()
      local conform = require('conform')
      local format_opts = { lsp_fallback = true, async = false, timeout_ms = 1000 }
      local bin = require('opsconfig.plugins.conform.formatters.bin')

      local formatters = {}

      formatters.shfmt = {
        inherit = false,
        command = 'shfmt',
        args = {
          '-i',
          '2',
          '-ci',
          '-s',
        },
        stdin = true,
      }

      formatters.systemd_analyze = {
        command = 'systemd-analyze',
        args = {
          'verify',
        },
        stdin = false,
      }

      formatters.nginxfmt = {
        inherit = false,
        command = 'nginxfmt',
        args = {
          '--indent',
          '2',
          '$FILENAME',
        },
        stdin = false,
      }

      local formatters_by_ft = {}

      formatters_by_ft.nginx = { 'nginxfmt' }
      formatters_by_ft.json = { 'prettier' }
      formatters_by_ft.markdown = { 'prettier' }
      formatters_by_ft.graphql = { 'prettier' }
      formatters_by_ft.sh = { 'shfmt' }
      formatters_by_ft.bash = { 'shfmt' }
      formatters_by_ft.zsh = { 'shfmt' }
      formatters_by_ft.systemd = { 'systemd_analyze' }

      conform.setup({
        log_level = vim.log.levels.WARN,
        notify_on_error = true,
        formatters = formatters,
        formatters_by_ft = formatters_by_ft,

        format_on_save = function(bufnr)
          conform.format(vim.tbl_extend('force', { bufnr = bufnr }, format_opts))
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',

    enabled = true,

    event = { 'BufReadPre', 'BufNewFile' },

    build = ':TSUpdate',

    dependencies = {
      { 'windwp/nvim-ts-autotag', enabled = true },
    },

    config = function()
      local treesitter = require('nvim-treesitter.configs')

      local available = {
        'bash',
        'c',
        'cmake',
        'comment',
        'desktop',
        'dockerfile',
        'editorconfig',
        'git_config',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'goctl',
        'gotmpl',
        'graphql',
        'html',
        'http',
        'ini',
        'java',
        'javadoc',
        'javascript',
        'jinja',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'kotlin',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'nginx',
        'perl',
        'prisma',
        'query',
        'regex',
        'robots',
        'scss',
        'sql',
        'svelte',
        'tsx',
        'twig',
        'typescript',
        'typespec',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      }

      treesitter.setup({
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
        fold = { enable = true },
        injection = { enable = true },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        ensure_installed = available,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',

    enabled = true,

    config = function()
      require('treesitter-context').setup({
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',

    enabled = true,
  },
  {
    'nvim-lualine/lualine.nvim',

    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = true },
      { 'catppuccin/nvim', enabled = true },
    },

    config = function()
      local lualine = require('lualine')
      local lazy_status = require('lazy.status')
      local setup = {}
      local plugins_updates_color = '#fab387'

      local noice = require('noice')

      setup.options = {
        theme = 'catppuccin',
      }

      setup.sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          'diagnostics',
        },
        lualine_c = {
          {
            'filename',
            path = 1,
            file_status = true,
            newfile_status = true,
            shorting_target = 40,
            symbols = {
              modified = ' ✎',
              readonly = ' ',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
            color = function()
              if vim.bo.modified then
                return { fg = '#f38ba8', gui = 'bold' }
              end

              return nil
            end,
          },
        },
        lualine_x = {
          {
            noice.api.statusline.mode.get,
            cond = noice.api.statusline.mode.has,
            color = { fg = '#ff9e64' },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = plugins_updates_color },
          },
          'encoding',
          'fileformat',
          {
            'filetype',
            icon = function()
              local ftype = vim.bo.filetype

              if ftype == 'vim' and vim.fn.expand('%:t') == 'vifmrc' then
                return ''
              else
                return require('nvim-web-devicons').get_icon_by_filetype(ftype, { default = true })
              end
            end,
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      }

      lualine.setup(setup)
    end,
  },
  {
    'okuuva/auto-save.nvim',

    cmd = 'ASToggle',

    event = {
      'InsertLeave',
      'TextChanged',
    },

    config = function()
      local autosave = require('auto-save')

      autosave.setup({
        enabled = true,
        write_all_buffers = false,
        noautocmd = false,
        lockmarks = false,
        debounce_delay = 2000,
        debug = false,

        trigger_events = {
          immediate_save = { 'BufLeave', 'FocusLost', 'QuitPre', 'VimSuspend' },

          defer_save = {
            'InsertLeave',
            'TextChanged',
            { 'User', pattern = 'VisualLeave' },
            { 'User', pattern = 'FlashJumpEnd' },
            { 'User', pattern = 'SnacksInputLeave' },
            { 'User', pattern = 'SnacksPickerInputLeave' },
          },

          cancel_deferred_save = {
            'InsertEnter',
            { 'User', pattern = 'VisualEnter' },
            { 'User', pattern = 'FlashJumpStart' },
            { 'User', pattern = 'SnacksInputEnter' },
            { 'User', pattern = 'SnacksPickerInputEnter' },
          },
        },

        condition = function(buf)
          if vim.fn.mode() == 'i' then
            return false
          end

          if require('luasnip').in_snippet() then
            return false
          end

          local blocked_filetypes = {
            'neo-tree', -- NeoTree file explorer
            'oil', -- oil.nvim file explorer
            'TelescopePrompt', -- Telescope prompt
            'lazy', -- lazy.nvim UI
            'lazygit', -- lazygit.nvim UI
            'toggleterm', -- toggleterm terminal buffer
            'OverseerList', -- overseer.nvim task manager
            'qf', -- quickfix window
            'diff', -- diff view
            'fugitive', -- fugitive buffers (caso use)
            'notify', -- nvim-notify (noice)
            'snacks_input', -- input temporário (custom plugin)
            'snacks_picker_input',
            'noice', -- noice.nvim popup
            'dap-repl', -- DAP REPL
            'dapui_watches', -- DAP UI
            'dapui_stacks',
            'dapui_breakpoints',
            'dapui_scopes',
            'dapui_console',
            'copilot-chat', -- caso use copilot-chat
            'gitcommit', -- mensagem de commit
            'sql', -- buffers SQL (evita salvar e rodar acidentalmente)
            'mysql', -- idem acima
            'harpoon', -- harpoon buffer
            'markdown', -- caso use render-markdown com buffer temporário
          }

          local ft = vim.bo[buf].filetype

          if vim.tbl_contains(blocked_filetypes, ft) then
            return false
          end

          return true
        end,

        callbacks = {
          before_saving = function()
            vim.notify('󱂬 Salvando...', vim.log.levels.INFO, { title = 'AutoSave', timeout = 300 })
          end,

          after_saving = function()
            vim.notify('󰄬 Salvo com sucesso', vim.log.levels.INFO, { title = 'AutoSave', timeout = 1000 })
          end,
        },
      })

      local wk = require('which-key')

      wk.add({
        {
          '<leader>ua',
          '<cmd>AutoSaveToggleNotify<CR>',
          desc = '󱂬 Alternar AutoSave',
          icon = { color = 'cyan', icon = '󱂬' },
          mode = 'n',
          noremap = true,
          silent = true,
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',

    enabled = true,

    dependencies = {
      { 'williamboman/mason.nvim', enabled = true },
      { 'williamboman/mason-lspconfig.nvim', enabled = true },
    },

    config = function()
      local lspconfig = require('lspconfig')

      local default_config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        }

        local flags = {
          debounce_text_changes = 150,
        }

        return capabilities, flags
      end

      local capabilities, flags = default_config()

      -- SECTION: LSP Servers
      lspconfig.bashls.setup({
        flags = flags,

        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        flags = flags,

        capabilities = capabilities,
      })

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

      -- SECTION: Inlay Hints and Client Actions

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('opsconfig-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
          end

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
        end,
      })
    end,
  },
  {
    'nvim-telescope/telescope-frecency.nvim',

    enabled = true,

    dependencies = {
      { 'nvim-telescope/telescope.nvim', enabled = true },
    },

    config = function()
      local telescope = require('telescope')

      telescope.load_extension('frecency')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',

    build = 'make',

    cond = function()
      return vim.fn.executable('make') == 1
    end,

    enabled = true,

    dependencies = {
      { 'nvim-telescope/telescope.nvim', enabled = true },
    },

    config = function()
      local telescope = require('telescope')

      telescope.load_extension('fzf')
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',

    enabled = true,

    dependencies = {
      { 'nvim-telescope/telescope.nvim', enabled = true },
    },

    config = function()
      local telescope = require('telescope')

      telescope.load_extension('ui-select')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',

    event = 'VimEnter',

    branch = '0.1.x',

    enabled = true,

    dependencies = {
      { 'nvim-lua/plenary.nvim', enabled = true },
      { 'nvim-tree/nvim-web-devicons', enabled = plugins.nvim_web_devicons },
    },

    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')

      telescope.setup({
        defaults = {
          mappings = {
            i = { ['<C-Enter>'] = 'to_fuzzy_refine' },
          },

          vimgrep_arguments = {},

          file_ignore_patterns = {},
        },

        extensions = {
          ['ui-select'] = {
            themes.get_dropdown(),
          },

          fzf = {},
        },
      })

      telescope.load_extension('noice')

      -- local keymap = require('opsconfig.helpers.telescope.keymap')
      -- local cwd = vim.fn.stdpath('config')
      --
      -- keymap.set_fn('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
      -- keymap.set_fn('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
      -- keymap.set_fn('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
      -- keymap.set_fn('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
      -- keymap.set_fn('<leader>sm', builtin.marks, '[S]earch [M]arks')
      -- keymap.set_fn('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
      -- keymap.set_fn('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      -- keymap.set_fn('<leader>sr', builtin.registers, '[S]earch [R]egisters')
      -- keymap.set_fn('<leader>s.', builtin.oldfiles, '[S]earch Recent Files')
      -- keymap.set_fn('<leader>sv', builtin.vim_options, '[S]earch NeoVim [O]ptions')
      -- keymap.set_fn('<leader>sc', builtin.commands, '[S]earch [C]ommands')
      -- keymap.set_fn('<leader>sb', builtin.buffers, '[S]earch [B]uffers')
      -- keymap.set_fn('<leader><leader>', builtin.buffers, 'Search Buffers')
      --
      -- keymap.set_find_files('<leader>sf', '[S]earch [F]iles', 'Project Files')
      -- keymap.set_find_files('<leader>sn', '[S]earch [N]eoVim Config Files', 'NeoVim Configuration Files', { cwd = cwd })
      -- keymap.set_find_files('<leader>so', '[S]earch [O]mni (Root Path)', 'NeoVim Configuration Files', { cwd = '/' })
      -- keymap.set_grep('<leader>s/', '[S]earch [/] in Open Files', 'Live Grep in Open Files', { grep_open_files = true })
      --
      -- local telescope_ag = vim.api.nvim_create_augroup('telescope_ag', { clear = true })
      --
      -- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      --   group = telescope_ag,
      --   callback = function()
      --     local current_cwd = vim.fn.expand('%:p:h')
      --     local buf = vim.api.nvim_get_current_buf()
      --
      --     keymap.set_find_files(
      --       '<leader>sF',
      --       '[S]earch Current [F]ile Path',
      --       'Current Directory Files',
      --       { cwd = current_cwd },
      --       'n',
      --       buf
      --     )
      --   end,
      -- })
    end,
  },
}
