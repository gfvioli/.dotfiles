return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim"},
    keys = {
        { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Toggle trouble list" },
        { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Toggle trouble workspace diagnostics" },
        { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Toggle trouble document diagnostics" },
        { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Toggle trouble quickfix list" },
        { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Toggle trouble location list" },
        { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
    },
}
