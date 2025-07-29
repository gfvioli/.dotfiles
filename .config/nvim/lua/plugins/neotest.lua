return {
  "nvim-neotest/neotest",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-neotest/nvim-nio" },
  opts = {
    adapters = {
      ["neotest-python"] = {
        dap = {
          justMyCode = false,
          console = "integratedTerminal",
        },
        args = { "--log-level", "DEBUG", "--quiet" },
        runner = "pytest",
        -- python = ".venv/bin/python",
      },
    },
  },
}
