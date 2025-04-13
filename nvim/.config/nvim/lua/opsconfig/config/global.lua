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
      phpcs = true,
      intelephense = false,
      phpactor = true,
      phpstan = true,
      php_codesniffer = true,
    },
  },

  lsp = {
    skip = false,
    auto_install = true,
  },

  formatters = {
    skip = false,
    auto_install = true,
  },

  linters = {
    skip = false,
    auto_install = true,
  },

  dap = {
    skip = false,
    auto_install = true,
  },

  fonts = {
    nerd_font_available = true,
    nerd_font = 'JetBrains Mono Nerd Font',
  },

  binaries = {
    python_path = os.getenv('OPSCONFIG_PYTHON_PATH') or '/home/linuxbrew/.linuxbrew/bin/python3',
  },
}
