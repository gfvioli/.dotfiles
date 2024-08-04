return {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    opts = {
        settings = {
            options = {
                notify_user_on_venv_activation = true,
            },
        },
    },
    ft = { "python", "quarto" },
    keys = { { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = { "python", "quarto" } } },
}
