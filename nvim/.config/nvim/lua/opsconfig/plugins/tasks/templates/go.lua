local overseer = require('overseer')

overseer.register_template({
  name = 'go',
  builder = function(params)
    local tasks = {}

    table.insert(tasks, {
      name = 'go get',
      cmd = 'go',
      args = { get = params.package },
      components = { 'default' },
    })

    table.insert(tasks, {
      name = 'go install',
      cmd = 'go',
      args = { get = params.package },
      components = { 'default' },
    })

    return tasks
  end,
  condition = {
    filetype = { 'go' },
  },
  params = {
    package = { type = 'string', desc = 'Go package to install' },
  },
})
