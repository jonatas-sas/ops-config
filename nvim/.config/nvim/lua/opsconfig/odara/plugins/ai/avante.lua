local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  AI-powered command palette and interface for Neovim.
  --  Uses local LLMs via Ollama to enhance interaction with Neovim.
  --  Boosts productivity by enabling natural language commands and queries.
  --  Configurable, with support for custom prompts, providers, and keybindings.
  --  Repository: https://github.com/yetone/avante.nvim
  'yetone/avante.nvim',

  event = 'VeryLazy',

  version = false,

  build = 'make',

  enabled = plugins.avante_nvim,

  opts = {
    provider = 'claude',
    claude = {
      endpoint = 'https://api.anthropic.com',
      model = 'claude-3-haiku-20240307',
      temperature = 0,
      timeout = 30000,
      max_tokens = 1024,
    },
  },
}
