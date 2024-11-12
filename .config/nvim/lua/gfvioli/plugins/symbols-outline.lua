return {
    'simrat39/symbols-outline.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("symbols-outline").setup()
        local keymap = vim.keymap

        keymap.set("n", "<leader>st", ":SymbolsOutlineOpen", { desc = "[S]ymbols Outline [O]pen" })
        keymap.set("n", "<leader>so", ":SymbolsOutlineOpen", { desc = "[S]ymbols Outline [O]pen" })
        keymap.set("n", "<leader>sq", ":SymbolsOutlineClose", { desc = "[S]ymbols Outline [C]lose" })
    end,
}
