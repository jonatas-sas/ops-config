vim.cmd('let g:netrw_liststyle = 3')

vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = vim.g.opsconfig.global.fonts.nerd_font_available

-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Global Status Line
vim.opt.laststatus = 3

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Complete
vim.opt.completeopt = {
  'noinsert',
  'menuone',
  'noselect',
}

-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
vim.opt.wrap = false -- disable line wrapping

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
vim.opt.cursorline = true -- highlight the current cursor line

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 1000

-- Decrease mapped sequence wait time
vim.o.timeout = true
vim.opt.timeoutlen = 1000
vim.o.ttimeoutlen = 10

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- appearance
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = 'yes' -- show sign column so that text doesn't shift

-- backspace
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ', -- Representação de tabulação
  trail = '·', -- Espaços em branco no final da linha
  nbsp = '␣', -- Espaços não quebráveis
  extends = '»', -- Indicação de texto escondido à direita
  precedes = '«', -- Indicação de texto escondido à esquerda
  eol = '↲', -- Exibe o fim da linha
  lead = '·', -- Indica espaços no início da linha
  multispace = '⋅', -- Diferencia múltiplos espaços
  leadmultispace = '│⋅', -- Representação especial para múltiplos espaços no início da linha
}

-- Splits
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- Swapfiles
vim.opt.swapfile = false

-- Folding Options
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'marker'

-- Python
vim.g.python_host_prog = vim.g.opsconfig.global.binaries.python_path
vim.g.python3_host_prog = vim.g.opsconfig.global.binaries.python_path
