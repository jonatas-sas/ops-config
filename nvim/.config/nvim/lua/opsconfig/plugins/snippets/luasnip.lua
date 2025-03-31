return {
  -- NOTE:  Sistema de snippets poderoso e extensível para Neovim.
  --  Suporte a múltiplos gatilhos, placeholders dinâmicos e expansões aninhadas.
  --  Integra-se com nvim-cmp para autocompletar snippets.
  --  Totalmente configurável, permitindo criação e personalização de snippets.
  --  Repositório: https://github.com/L3MON4D3/LuaSnip
  'L3MON4D3/LuaSnip',

  enabled = vim.g.opsconfig.plugins.cmp_luasnip,

  version = 'v2.*',

  event = 'InsertEnter',

  build = 'make install_jsregexp',

  config = function()
    local ls = require('luasnip')

    -- Snippets {{{

    require('luasnip.loaders.from_lua').lazy_load({
      paths = { vim.fn.stdpath('config') .. '/lua/opsconfig/plugins/snippets/source' },
    })

    -- }}}

    -- Setup {{{

    ls.config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = false,
    })

    -- }}}

    -- Keymaps {{{

    vim.keymap.set({ 'i', 's' }, '<C-k>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-j>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set('i', '<C-l>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    -- }}}
  end,
}
