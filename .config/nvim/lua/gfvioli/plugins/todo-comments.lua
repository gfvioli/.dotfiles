return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*\S*\s*:]],
        },
    },
    config = function()
        local todo_comments = require("todo-comments")

        local keymap = vim.keymap -- reduce typing

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next TODO comment" })


        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous TODO comment" })

        todo_comments.setup(
        )
    end,
}
