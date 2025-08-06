local HOME = os.getenv("HOME")
return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "christoomey/vim-tmux-navigator", event = { "BufReadPre", "BufNewFile" } },
  { "preservim/vim-pencil", event = { "BufReadPre", "BufNewFile" } },
  { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } }, -- Adjusting shiftdwith and expandtab heuristically
  -- {
  --   "akinsho/toggleterm.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   version = "*",
  --   config = true,
  --   keys = { { "<leader>tt", ":ToggleTerm direction=float <CR>" } },
  -- },
  {
    "ThePrimeagen/git-worktree.nvim",

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git-worktree").setup({})
    end,
  },
  { "linux-cultist/venv-selector.nvim", enabled = true, ft = { "python", "quarto" } },
  { "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = false } } },
  {
    "mbbill/undotree",
    event = "BufEnter",
    keys = { { "<leader>tu", "<cmd>UndotreeToggle<CR>", mode = "n", { desc = "Toggle undo tree" } } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", HOME .. "/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
}
