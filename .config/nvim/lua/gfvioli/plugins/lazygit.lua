return {
    "kdheepak/lazygit.vim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },

    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    keys = {
        { "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open [L]azy[G]it" },
    },
}
