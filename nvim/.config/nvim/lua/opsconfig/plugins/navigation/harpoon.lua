return {
  -- NOTE:  Navegação rápida entre arquivos no Neovim.
  --  Permite marcar arquivos e alternar entre eles com atalhos dedicados.
  --  Acelera o fluxo de trabalho com acesso instantâneo aos favoritos.
  --  Configurável, com suporte a múltiplos menus e integração com Telescope.
  --  Repositório: https://github.com/ThePrimeagen/harpoon
  'ThePrimeagen/harpoon',

  branch = 'harpoon2',

  enabled = vim.g.opsconfig.plugins.harpoon
    and vim.g.opsconfig.plugins.plenary_nvim
    and vim.g.opsconfig.plugins.telescope_nvim
    and vim.g.opsconfig.plugins.which_key_nvim,

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

    -- NOTE:  Fuzzy finder altamente extensível para Neovim.
    --  Busca rápida em arquivos, buffers, LSP, comandos e muito mais.
    --  Integra-se com ripgrep, fd, fzf e plugins externos.
    --  Altamente configurável e personalizável com atalhos e extensões.
    --  Repositório: https://github.com/nvim-telescope/telescope.nvim
    {
      'nvim-telescope/telescope.nvim',
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
    local harpoon = require('harpoon')

    harpoon:setup({
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        enter_on_sendcmd = false,
        mark_branch = false,
      },
    })

    local harpoon_extensions = require('harpoon.extensions')
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    harpoon:extend(harpoon_extensions.builtins.navigate_with_number())

    -- Keymaps {{{

    local wk = require('which-key')

    wk.add({
      { '<leader>n', group = 'Navigation', icon = '󰛢' },
      {
        '<leader>na',
        function()
          harpoon:list():add()
        end,
        desc = '[N]avigation: [A]dd file',
        icon = { color = 'blue', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>nm',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = '[N]avigation: [M]enu',
        icon = { color = 'yellow', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>nn',
        function()
          harpoon:list():next()
        end,
        desc = '[N]avigation: [N]ext file',
        icon = { color = 'cyan', icon = '󰮳' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>np',
        function()
          harpoon:list():prev()
        end,
        desc = '[N]avigation: [P]revious file',
        icon = { color = 'cyan', icon = '󰮨' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-N>',
        function()
          harpoon:list():next()
        end,
        desc = '[N]avigation: [N]ext file',
        icon = { color = 'cyan', icon = '󰮳' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<C-S-P>',
        function()
          harpoon:list():prev()
        end,
        desc = '[N]avigation: [P]revious file',
        icon = { color = 'cyan', icon = '󰮨' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>n1',
        function()
          harpoon:list():select(1)
        end,
        desc = '[N]avigation: File [1]',
        icon = { color = 'azure', icon = '󰧯' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>n2',
        function()
          harpoon:list():select(2)
        end,
        desc = '[N]avigation: File [2]',
        icon = { color = 'azure', icon = '󰧯' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>n3',
        function()
          harpoon:list():select(3)
        end,
        desc = '[N]avigation: File [3]',
        icon = { color = 'azure', icon = '󰧯' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>n4',
        function()
          harpoon:list():select(4)
        end,
        desc = '[N]avigation: File [4]',
        icon = { color = 'azure', icon = '󰧯' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>nt',
        '<cmd>Telescope harpoon marks<cr>',
        desc = '[N]avigation: [T]elescope marks',
        icon = { color = 'purple', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })

    -- }}}
  end,
}
