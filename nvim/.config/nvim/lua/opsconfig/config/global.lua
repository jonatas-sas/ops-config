return {
  is_dev = true,
  is_servers = false,

  files = {
    hidden_files = false,
    git_no_ignore = false,
    git_no_ignore_parent = false,
    follow_symlinks = true,
    vimgrep_arguments = require('opsconfig.config.defaults.vimgrep-arguments'),
    ignore_patterns = require('opsconfig.config.defaults.ignore-patters-files'),
    tree_ignore_patterns = require('opsconfig.config.defaults.ignore-patters-tree'),
  },

  remote_server = {
    enabled = false,
  },

  project = {
    is_default = true,
    is_main = false,
    is_php_yii = false,
    is_php_wordpress = false,
  },

  tasks = {
    enabled = false,
  },

  skip_lsp = false,
  skip_none_ls = false,
  has_nerd_font = true,

  languages = {
    lua = {
      enabled = true,
      lsp = true,
      fidget = true,
      null_ls = true,
      formatter = true,
      linter = true,
    },

    go = {
      enabled = true,
      delve = true,
      linter = true,
    },

    php = {
      enabled = true,
      xdebug = true,
      intelephense = false,
      phpactor = true,
      phpstan = false,
      phpcs = false,
      phpmd = false,
    },
  },

  lsp = {
    skip = false,
  },

  dap = {
    skip = false,
  },

  linters = {
    enable_phpstan = false,
    enable_phpcs = false,
    enable_phpmd = false,
    enable_golangci_lint = false,
  },

  fonts = {
    nerd_font_available = true,
    nerd_font = 'JetBrains Mono Nerd Font',
  },

  binaries = {
    python_path = os.getenv('OPSCONFIG_PYTHON_PATH') or '/home/linuxbrew/.linuxbrew/bin/python3',
  },
}
