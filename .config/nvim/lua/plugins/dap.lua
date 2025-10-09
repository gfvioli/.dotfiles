return {
  "mfussenegger/nvim-dap",
  optional = false,
  lazy = false,
  dependencies = {
    {
      "mfussenegger/nvim-dap-python",
      keys = {
        {
          "<leader>dPt",
          function()
            require("dap-python").test_method()
          end,
          desc = "Debug Method",
          ft = "python",
        },
        {
          "<leader>dPc",
          function()
            require("dap-python").test_class()
          end,
          desc = "Debug Class",
          ft = "python",
        },
      },
    },
  },
  config = function()
    local dap = require("dap")
    require("dap-python").setup("uv")
    table.insert(dap.configurations.python, {
      name = "Python Current File",
      type = "debugpy",
      request = "launch",
      command = {
        env = { LOCAL_RUN = "True" },
      },
      program = "${file}",
      pythonPath = ".venv/bin/python",
    })
    table.insert(dap.configurations.python, {
      name = "dagster-dev",
      type = "debugpy",
      request = "launch",
      module = "dagster",
      args = { "dev" },
      command = {
        env = { LOCAL_RUN = "1" },
      },
      subProcess = true,
      pythonPath = ".venv/bin/python",
    })
  end,
}
