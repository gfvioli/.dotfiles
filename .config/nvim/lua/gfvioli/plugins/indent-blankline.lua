return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "3.8.2",
    main = "ibl",
    opts = {
        indent = { char = "┊" },
    }
}
