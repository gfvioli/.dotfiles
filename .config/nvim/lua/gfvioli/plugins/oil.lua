return {
    'https://github.com/stevearc/oil.nvim',
    opts = {},
    event = "VeryLazy",
    dependencies = {
        -- 'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('oil').setup({
            default_file_explorer = false,
        })
    end,
}
