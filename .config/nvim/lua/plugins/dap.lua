return {
  "mfussenegger/nvim-dap",
  table.insert(require("nvim-dap").configurations.python, {
    {
      name = "Python Current File",
      type = "debugpy",
      request = "launch",
      command = {
        env = { LOCAL_RUN = "True" },
      },
      program = "${file}",
      pythonPath = ".venv/bin/python",
    },
    {
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
    },
  }),
}
