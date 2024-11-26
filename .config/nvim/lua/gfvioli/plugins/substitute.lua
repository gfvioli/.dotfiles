return {
    "gbprod/substitute.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local substitute = require("substitute")

        substitute.setup()

        local keymap = vim.keymap -- reduce typing

        keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
        keymap.set("n", "ss", substitute.line, { desc = "Substitute with line" })
        keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
        keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
    end,
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    keys = {
        {
            "<leader>rs",
            function() require("rip-substitute").sub() end,
            mode = { "n", "x" },
            desc = " rip substitute",
        },
    },
}
