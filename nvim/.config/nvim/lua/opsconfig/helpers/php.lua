local M = {}

M.get_php_version = function()
  local root = vim.fn.getcwd()
  local path = root .. '/composer.json'

  if vim.fn.filereadable(path) == 0 then
    return nil
  end

  local json = vim.fn.readfile(path)
  if not json then
    return nil
  end

  local success, composer_data = pcall(vim.fn.json_decode, table.concat(json, '\n'))

  if not success or type(composer_data) ~= 'table' then
    return nil
  end

  local php_version = composer_data.config and composer_data.config.platform and composer_data.config.platform.php

  if php_version then
    return php_version:match('^(%d+%.%d+)') -- Extract `8.1` from `8.1.5`
  end

  local require_php = composer_data.require and composer_data.require.php

  if require_php then
    return require_php:match('(%d+%.%d+)') -- Extract `8.0` from `>=8.0.2`
  end

  return nil
end

M.compare_php_version = function(version, operator)
  local php_version = M.get_php_version()

  if not php_version then
    return nil, 'No PHP version found in composer.json'
  end

  local function version_to_number(v)
    local major, minor = v:match('^(%d+)%.(%d+)')

    return tonumber(major) * 100 + tonumber(minor)
  end

  local v1 = version_to_number(php_version)
  local v2 = version_to_number(version)

  local comparisons = {
    ['<'] = function(a, b)
      return a < b
    end,
    ['>'] = function(a, b)
      return a > b
    end,
    ['<='] = function(a, b)
      return a <= b
    end,
    ['>='] = function(a, b)
      return a >= b
    end,
    ['=='] = function(a, b)
      return a == b
    end,
    ['~='] = function(a, b)
      return a ~= b
    end,
  }

  local compare_fn = comparisons[operator]

  if not compare_fn then
    return nil, 'Invalid operator: ' .. tostring(operator)
  end

  return compare_fn(v1, v2)
end

return M
