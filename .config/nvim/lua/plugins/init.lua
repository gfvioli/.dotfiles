return {
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "preservim/vim-pencil",
  "tpope/vim-sleuth", -- Adjusting shiftdwith and expandtab heuristically
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = { { "<leader>to", ":ToggleTerm direction=float <CR>" } },
  },
  {
    "ThePrimeagen/git-worktree.nvim",

    event = "VeryLazy",
    config = function()
      require("git-worktree").setup({})
    end,
  },
}
