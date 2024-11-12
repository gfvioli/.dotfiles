return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        -- import nvim-treesitter
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({
            highlight = {
                enable = true -- enable syntax highlighting
            },

            -- enable indentation
            indent = { enable = true },

            autotag = {
                enable = true,
            },

            ensure_installed = {
                "lua",
                "python",
                "rust",
                "yaml",
                "toml",
                "sql",
                "regex",
                "json",
                "markdown",
                "markdown_inline",
                "bash",
                "dockerfile",
                "gitignore",
                "vim",
                "vimdoc",
                "query",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    end,
}
