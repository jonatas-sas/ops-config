local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:  Markdown rendering directly within Neovim.
  --  Converts `.md` files into richly formatted buffers.
  --  Ideal for reading documentation and editing with inline previews.
  --  Configurable with theme support and integration with visual plugins.
  --  Repository: https://github.com/MeanderingProgrammer/render-markdown.nvim
  'MeanderingProgrammer/render-markdown.nvim',

  enabled = plugins.render_markdown_nvim and plugins.nvim_treesitter and plugins.nvim_web_devicons,

  ft = {
    'markdown',
    'md',
  },

  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', enabled = true },
    { 'nvim-tree/nvim-web-devicons', enabled = true },
  },

  opts = {
    bullet = {
      enabled = true,
    },

    checkbox = {
      enabled = true,
      position = 'inline',
      unchecked = {
        icon = '   󰄱 ',
        highlight = 'RenderMarkdownUnchecked',
        scope_highlight = nil,
      },
      checked = {
        icon = '   󰱒 ',
        highlight = 'RenderMarkdownChecked',
        scope_highlight = nil,
      },
    },

    html = {
      enabled = true,
      comment = {
        conceal = false,
      },
    },

    link = {
      image = vim.g.neovim_mode == 'skitty' and '' or '󰥶 ',
      custom = {
        youtu = { pattern = 'youtu%.be', icon = '󰗃 ' },
      },
    },

    heading = {
      sign = false,
      icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
      backgrounds = {
        'Headline1Bg',
        'Headline2Bg',
        'Headline3Bg',
        'Headline4Bg',
        'Headline5Bg',
        'Headline6Bg',
      },
      foregrounds = {
        'Headline1Fg',
        'Headline2Fg',
        'Headline3Fg',
        'Headline4Fg',
        'Headline5Fg',
        'Headline6Fg',
      },
    },
  },

  config = function()
    local color1_bg = '#1e1e2e' -- base
    local color2_bg = '#313244' -- surface0
    local color3_bg = '#45475a' -- surface1
    local color4_bg = '#585b70' -- surface2
    local color5_bg = '#6c7086' -- overlay0
    local color6_bg = '#7f849c' -- overlay1
    local colorInline_bg = '#313244' -- inline code background
    local color_fg = '#cdd6f4' -- texto principal

    -- Headings
    vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s]], color_fg, color1_bg))
    vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s]], color_fg, color2_bg))
    vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s]], color_fg, color3_bg))
    vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s]], color_fg, color4_bg))
    vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s]], color_fg, color5_bg))
    vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s]], color_fg, color6_bg))

    -- Inline code
    vim.cmd(string.format([[highlight RenderMarkdownCodeInline guifg=%s guibg=%s]], colorInline_bg, color_fg))

    -- Heading signs
    vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
    vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
    vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
    vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
    vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
    vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
  end,
}
