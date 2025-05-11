local M = {}

local config_path = vim.fn.stdpath('config') .. '/externals'

M.phpcs = function(config)
  local phpcs_path = config_path .. '/php/formatters/php-cs-fixer/default.php'

  return {
    inherit = false,
    command = 'php-cs-fixer',
    args = {
      'fix',
      '--config=' .. phpcs_path,
      '--using-cache=no',
      '--allow-risky=yes',
      '--verbose',
      '$FILENAME',
    },
    stdin = false,
  }
end

M.kdlfmt = function()
  return {
    command = vim.fn.expand('~') .. '/.cargo/bin/kdlfmt',
    args = {
      'format',
      '$FILENAME',
    },
    stdin = false,
  }
end

M.shfmt = function()
  return {
    inherit = false,
    command = 'shfmt',
    args = {
      '-i',
      '2',
      '-ci',
      '-s',
    },
    stdin = true,
  }
end

M.systemd_analyze = function()
  return {
    command = 'systemd-analyze',
    args = {
      'verify',
    },
    stdin = false,
  }
end

M.nginxfmt = function()
  return {
    inherit = false,
    command = 'nginxfmt',
    args = {
      '--indent',
      '2',
      '$FILENAME',
    },
    stdin = false,
  }
end

return M
