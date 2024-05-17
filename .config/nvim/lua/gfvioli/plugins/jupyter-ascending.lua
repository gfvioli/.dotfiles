return {
    "imbue-ai/jupyter_ascending.vim",
    config = function()
        local keymap = vim.keymap
        keymap.set("n", "<leader>jx", "<cmd>JupyterExecute<CR>", { desc = "Execute current cell" })
        keymap.set("n", "<leader>jX", "<cmd>JupyterExecuteAll<CR>", { desc = "Execute all cells" })
        keymap.set("n", "<leader>jr", "<cmd>JupyterRestart<CR>", { desc = "Execute all cells" })
    end,
}
