local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  File manager for Neovim that treats directories as editable buffers.
  --  Allows navigating and manipulating files as if they were regular buffers.
  --  Simplifies file editing without relying on external file explorers.
  --  Configurable with custom keybindings and LSP integration support.
  --  Repository: https://github.com/stevearc/oil.nvim
  'stevearc/oil.nvim',

  lazy = false,

  enabled = plugins.oil_nvim and plugins.nvim_web_devicons,

  depends = {
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  config = function()
    -- SECTION: Setup
    require('oil').setup({
      default_file_explorer = true,

      columns = {
        'icon',
      },

      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },

      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },

      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,

      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },

      constrain_cursor = 'editable',
      watch_for_changes = false,

      keymaps = {
        ['<Esc>'] = { 'actions.close', mode = 'n' },
        ['g?'] = { 'actions.show_help', mode = 'n' },
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-h>'] = { 'actions.select', opts = { horizontal = true } },
        ['<C-t>'] = { 'actions.select', opts = { tab = true } },
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = { 'actions.close', mode = 'n' },
        ['<C-l>'] = 'actions.refresh',
        ['-'] = { 'actions.parent', mode = 'n' },
        ['_'] = { 'actions.open_cwd', mode = 'n' },
        ['`'] = { 'actions.cd', mode = 'n' },
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
        ['gs'] = { 'actions.change_sort', mode = 'n' },
        ['gx'] = 'actions.open_external',
        ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
      },

      use_default_keymaps = true,

      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, _)
          return name:match('^%.') ~= nil
        end,
        is_always_hidden = function(_, _)
          return false
        end,
        natural_order = 'fast',
        case_insensitive = false,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
        highlight_filename = function(_, is_hidden, is_link_target, is_link_orphan)
          if is_hidden then
            return 'Comment'
          elseif is_link_orphan then
            return 'WarningMsg'
          elseif is_link_target then
            return 'Directory'
          else
            return 'Normal'
          end
        end,
      },

      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        get_win_title = nil,
        preview_split = 'auto',
        override = function(conf)
          return conf
        end,
      },

      preview_win = {
        update_on_cursor_moved = true,
        preview_method = 'scratch',
        disable_preview = function(_)
          return false
        end,
        win_options = {
          wrap = false,
          number = true,
          relativenumber = false,
        },
      },

      confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },

      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = {
          winblend = 0,
        },
      },

      ssh = {
        border = 'rounded',
      },

      keymaps_help = {
        border = 'rounded',
      },
    })
  end,
}
