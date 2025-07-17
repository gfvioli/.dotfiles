return {
  { "christoomey/vim-tmux-navigator", event = { "BufReadPre", "BufNewFile" } },
  { "preservim/vim-pencil", event = { "BufReadPre", "BufNewFile" } },
  { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } }, -- Adjusting shiftdwith and expandtab heuristically
  {
    "akinsho/toggleterm.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
    keys = { { "<leader>tt", ":ToggleTerm direction=float <CR>" } },
  },
  {
    "ThePrimeagen/git-worktree.nvim",

    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git-worktree").setup({})
    end,
  },
  { "linux-cultist/venv-selector.nvim", enabled = true, ft = { "python", "quarto" } },
  { "mason-org/mason.nvim", version = "1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "1.0.0" },
  { "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = false } } },
}
