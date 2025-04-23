return {
  { "christoomey/vim-tmux-navigator", event = { "BufReadPre", "BufNewFile" } },
  { "preservim/vim-pencil", event = { "BufReadPre", "BufNewFile" } },
  { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } }, -- Adjusting shiftdwith and expandtab heuristically
  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
    keys = { { "<leader>to", ":ToggleTerm direction=float <CR>" } },
  },
  {
    "ThePrimeagen/git-worktree.nvim",

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git-worktree").setup({})
    end,
  },
  { "linux-cultist/venv-selector.nvim", enabled = true, ft = { "python", "quarto" } },
}
