return {
    'theprimeagen/harpoon',
    event = "VeryLazy",
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        local keymap = vim.keymap

        keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon: [A]ppend file" })
        keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "[H]arpoon: [M]enu" })

        keymap.set("n", "<C-M-h>", function() ui.nav_file(1) end, { desc = "Go to harpoon file 1" })
        keymap.set("n", "<C-M-j>", function() ui.nav_file(2) end, { desc = "Go to harpoon file 2" })
        keymap.set("n", "<C-M-k>", function() ui.nav_file(3) end, { desc = "Go to harpoon file 3" })
        keymap.set("n", "<C-M-l>", function() ui.nav_file(4) end, { desc = "Go to harpoon file 4" })
    end,
}
