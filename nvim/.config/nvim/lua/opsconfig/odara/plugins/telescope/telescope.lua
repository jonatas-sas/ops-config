local plugins = vim.g.opsconfig.plugins
local global = vim.g.opsconfig.global

return {
  -- NOTE:  Highly extensible fuzzy finder for Neovim.
  --  Fast searching across files, buffers, LSP symbols, commands, and more.
  --  Integrates with ripgrep, fd, fzf, and external plugins.
  --  Fully customizable with keybindings and a wide range of extensions.
  --  Repository: https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',

  event = 'VimEnter',

  branch = '0.1.x',

  enabled = plugins.telescope_nvim and plugins.plenary_nvim,

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

        vimgrep_arguments = global.files.vimgrep_arguments,

        file_ignore_patterns = global.files.ignore_patterns,
      },

      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },

        fzf = {},
      },
    })

    -- Extensions Loader {{{

    if plugins.noice_nvim then
      telescope.load_extension('noice')
    end

    --- }}}

    -- Keymaps {{{

    local keymap = require('opsconfig.helpers.telescope.keymap')
    local cwd = vim.fn.stdpath('config')

    keymap.set_fn('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
    keymap.set_fn('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
    keymap.set_fn('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
    keymap.set_fn('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
    keymap.set_fn('<leader>sm', builtin.marks, '[S]earch [M]arks')
    keymap.set_fn('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
    keymap.set_fn('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
    keymap.set_fn('<leader>sr', builtin.registers, '[S]earch [R]egisters')
    keymap.set_fn('<leader>s.', builtin.oldfiles, '[S]earch Recent Files')
    keymap.set_fn('<leader>sv', builtin.vim_options, '[S]earch NeoVim [O]ptions')
    keymap.set_fn('<leader>sc', builtin.commands, '[S]earch [C]ommands')
    keymap.set_fn('<leader>sb', builtin.buffers, '[S]earch [B]uffers')
    keymap.set_fn('<leader><leader>', builtin.buffers, 'Search Buffers')

    keymap.set_find_files('<leader>sf', '[S]earch [F]iles', 'Project Files')
    keymap.set_find_files('<leader>sn', '[S]earch [N]eoVim Config Files', 'NeoVim Configuration Files', { cwd = cwd })
    keymap.set_find_files('<leader>so', '[S]earch [O]mni (Root Path)', 'NeoVim Configuration Files', { cwd = '/' })
    keymap.set_grep('<leader>s/', '[S]earch [/] in Open Files', 'Live Grep in Open Files', { grep_open_files = true })

    local telescope_ag = vim.api.nvim_create_augroup('telescope_ag', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      group = telescope_ag,
      callback = function()
        local current_cwd = vim.fn.expand('%:p:h')
        local buf = vim.api.nvim_get_current_buf()

        keymap.set_find_files(
          '<leader>sF',
          '[S]earch Current [F]ile Path',
          'Current Directory Files',
          { cwd = current_cwd },
          'n',
          buf
        )
      end,
    })

    -- }}}
  end,
}
