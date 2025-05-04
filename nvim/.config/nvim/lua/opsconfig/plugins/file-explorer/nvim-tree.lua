local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Gerenciador de arquivos em árvore para Neovim.
  --  Suporte a ícones, atalhos e integração com git.
  --  Permite navegação rápida e manipulação de arquivos diretamente no editor.
  --  Leve, altamente configurável e substitui o netrw.
  --  Repositório: https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',

  enabled = plugins.nvim_tree_lua and plugins.nvim_web_devicons,

  dependencies = {
    { 'klen/nvim-config-local', enabled = plugins.nvim_config_local },
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  config = function()
    local nvimtree = require('nvim-tree')

    -- SECTION: Setup
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

    
    -- SECTION: Keymaps

    -- Keymaps Config: ../../core/keymaps.lua
  end,
}
