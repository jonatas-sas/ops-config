return {
  -- NOTE:  Gerenciador de arquivos em árvore para Neovim.
  --  Suporte a ícones, atalhos e integração com git.
  --  Permite navegação rápida e manipulação de arquivos diretamente no editor.
  --  Leve, altamente configurável e substitui o netrw.
  --  Repositório: https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',

  enabled = vim.g.opsconfig.plugins.nvim_tree_lua
    and vim.g.opsconfig.plugins.nvim_web_devicons
    and vim.g.opsconfig.plugins.which_key_nvim,

  dependencies = {
    -- NOTE:  Plugin para carregar configurações locais no Neovim.
    --  Permite executar arquivos `.nvim.lua`, `.nvimrc.lua` e similares em diretórios específicos.
    --  Suporte a listas de permissões e confirmações para segurança.
    --  Útil para projetos que exigem configurações específicas sem poluir a config global.
    --  Repositório: https://github.com/klen/nvim-config-local
    {
      'klen/nvim-config-local',
      enabled = vim.g.opsconfig.plugins.nvim_config_local,
    },

    -- NOTE:  Ícones para arquivos e diretórios no Neovim.
    --  Integra-se com plugins como nvim-tree, telescope e lualine.
    --  Suporte a múltiplos temas e personalização de ícones.
    --  Requer uma fonte Nerd Font para exibição correta.
    --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
    {
      'nvim-tree/nvim-web-devicons',
      enabled = true,
    },

    -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
    --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
    --  Ajuda a memorizar atalhos e melhorar a produtividade.
    --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
    --  Repositório: https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      enabled = true,
    },
  },

  config = function()
    local nvimtree = require('nvim-tree')

    -- Setup {{{

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

      filters = {
        custom = vim.g.opsconfig.global.files.tree_ignore_patterns,
        dotfiles = vim.g.opsconfig.global.files.dotfiles,
        git_ignored = not vim.g.opsconfig.global.files.git_no_ignore,
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

    -- }}}

    require('nvim-web-devicons').set_icon({
      vifmrc = {
        icon = '', -- Ícone personalizado
        color = '#FFA500',
        cterm_color = '214',
        name = 'Vifmrc',
      },
    })

    -- Keymaps {{{

    local wk = require('which-key')

    wk.add({
      {
        '<leader>ee',
        '<cmd>NvimTreeToggle<CR>',
        desc = 'Toggle File [E]xplor[e]r',
        icon = { color = 'yellow', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>er',
        '<cmd>NvimTreeRefresh<CR>',
        desc = 'File [E]xplorer: [R]efresh',
        icon = { color = 'blue', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>ec',
        '<cmd>NvimTreeCollapse<CR>',
        desc = 'File [E]xplorer: [C]ollapse',
        icon = { color = 'orange', icon = '󰜺' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })

    -- }}}
  end,
}
