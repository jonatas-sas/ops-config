return {
  -- NOTE:  Renderização de Markdown diretamente no Neovim.
  --  Converte arquivos `.md` em buffers renderizados com formatação enriquecida.
  --  Ideal para leitura de documentação e edição com preview embutido.
  --  Configurável, com suporte a temas e integração com plugins visuais.
  --  Repositório: https://github.com/MeanderingProgrammer/render-markdown.nvim
  'MeanderingProgrammer/render-markdown.nvim',

  enabled = vim.g.opsconfig.plugins.render_markdown_nvim
    and vim.g.opsconfig.plugins.nvim_treesitter
    and vim.g.opsconfig.plugins.nvim_web_devicons,

  ft = {
    'markdown',
  },

  -- Dependencies {{{

  dependencies = {
    -- NOTE:  Fornece parsing avançado de código-fonte usando árvores sintáticas (Tree-sitter).
    --  Melhora realce de sintaxe, folds, indentação e análise estrutural do código.
    --  Suporte a múltiplas linguagens com instalação e atualização automática de parsers.
    --  Extensível, permitindo desenvolvimento de funcionalidades baseadas em árvore sintática.
    --  Repositório: https://github.com/nvim-treesitter/nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      enabled = true,
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
  },

  -- }}}

  opts = {
    bullet = {
      -- Turn on / off list bullet rendering
      enabled = true,
    },

    checkbox = {
      -- Turn on / off checkbox state rendering
      enabled = true,
      -- Determines how icons fill the available space:
      --  inline:  underlying text is concealed resulting in a left aligned icon
      --  overlay: result is left padded with spaces to hide any additional text
      position = 'inline',
      unchecked = {
        -- Replaces '[ ]' of 'task_list_marker_unchecked'
        icon = '   󰄱 ',
        -- Highlight for the unchecked icon
        highlight = 'RenderMarkdownUnchecked',
        -- Highlight for item associated with unchecked checkbox
        scope_highlight = nil,
      },
      checked = {
        -- Replaces '[x]' of 'task_list_marker_checked'
        icon = '   󰱒 ',
        -- Highlight for the checked icon
        highlight = 'RenderMarkdownChecked',
        -- Highlight for item associated with checked checkbox
        scope_highlight = nil,
      },
    },

    html = {
      -- Turn on / off all HTML rendering
      enabled = true,
      comment = {
        -- Turn on / off HTML comment concealing
        conceal = false,
      },
    },

    -- Add custom icons lamw26wmal
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
