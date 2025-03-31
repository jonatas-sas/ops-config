return {
  -- NOTE:  Fuzzy finder altamente extensível para Neovim.
  --  Busca rápida em arquivos, buffers, LSP, comandos e muito mais.
  --  Integra-se com ripgrep, fd, fzf e plugins externos.
  --  Altamente configurável e personalizável com atalhos e extensões.
  --  Repositório: https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',

  event = 'VimEnter',

  branch = '0.1.x',

  enabled = vim.g.opsconfig.plugins.telescope_nvim and vim.g.opsconfig.plugins.plenary_nvim,

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

    -- NOTE:  Extensão do Telescope para busca ultrarrápida com FZF nativo.
    --  Usa C para melhor desempenho na correspondência fuzzy.
    --  Suporte a ordenação inteligente e prévia rápida de resultados.
    --  Requer compilação, mas melhora significativamente a velocidade de busca.
    --  Repositório: https://github.com/nvim-telescope/telescope-fzf-native.nvim
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      enabled = true,
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },

    -- NOTE:  Substitui `vim.ui.select` pela interface do Telescope no Neovim.
    --  Permite usar a experiência do Telescope para menus de seleção.
    --  Melhora a navegação e a busca em diálogos interativos.
    --  Leve, fácil de configurar e compatível com outros plugins.
    --  Repositório: https://github.com/nvim-telescope/telescope-ui-select.nvim
    {
      'nvim-telescope/telescope-ui-select.nvim',
      enabled = true,
    },

    -- NOTE:  Ícones para arquivos e diretórios no Neovim.
    --  Integra-se com plugins como nvim-tree, telescope e lualine.
    --  Suporte a múltiplos temas e personalização de ícones.
    --  Requer uma fonte Nerd Font para exibição correta.
    --  Repositório: https://github.com/nvim-tree/nvim-web-devicons
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.opsconfig.plugins.nvim_web_devicons,
    },

    -- NOTE:  Integração do DAP (Debug Adapter Protocol) com Telescope.
    --  Facilita a navegação por breakpoints, frames, threads e variáveis.
    --  Melhora o fluxo de depuração com buscas rápidas e eficientes.
    --  Configurável, suportando filtros e atalhos personalizados.
    --  Repositório: https://github.com/nvim-telescope/telescope-dap.nvim
    {
      'nvim-telescope/telescope-dap.nvim',
      enabled = vim.g.opsconfig.plugins.telescope_dap_nvim,
    },

    -- NOTE: Extensão do Telescope para integração com o LuaSnip no Neovim.
    -- Permite pesquisar e inserir snippets do LuaSnip através da interface do Telescope.
    -- Facilita a visualização e inserção de trechos de código de forma interativa.
    -- Repositório: https://github.com/benfowler/telescope-luasnip.nvim
    {
      'benfowler/telescope-luasnip.nvim',
      enabled = vim.g.opsconfig.plugins.luasnip and vim.g.opsconfig.plugins.telescope_luasnip_nvim,
    },
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

        vimgrep_arguments = vim.g.opsconfig.global.files.vimgrep_arguments,

        file_ignore_patterns = vim.g.opsconfig.global.files.ignore_patterns,
      },

      extensions = {
        ['ui-select'] = {
          themes.get_dropdown(),
        },

        fzf = {},
      },
    })

    -- Extensions Loader {{{

    telescope.load_extension('ui-select')
    telescope.load_extension('fzf')

    if vim.g.opsconfig.plugins.noice_nvim then
      telescope.load_extension('noice')
    end

    if vim.g.opsconfig.plugins.luasnip and vim.g.opsconfig.plugins.telescope_luasnip_nvim then
      telescope.load_extension('luasnip')
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
