local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Powerful and extensible snippet engine for Neovim.
  --  Supports multiple triggers, dynamic placeholders, and nested expansions.
  --  Integrates with nvim-cmp for snippet autocompletion.
  --  Fully configurable, allowing custom snippet creation and behavior.
  --  Repository: https://github.com/L3MON4D3/LuaSnip
  'L3MON4D3/LuaSnip',

  enabled = plugins.cmp_luasnip,

  version = 'v2.*',

  event = 'InsertEnter',

  build = 'make install_jsregexp',

  config = function()
    local ls = require('luasnip')

    -- SECTION: Snippets Loader

    require('luasnip.loaders.from_lua').lazy_load({
      paths = { vim.fn.stdpath('config') .. '/lua/opsconfig/plugins/snippets/source' },
    })

    -- SECTION: Setup

    ls.config.set_config({
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = false,
    })

    -- SECTION: Keymaps

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
  end,
}
