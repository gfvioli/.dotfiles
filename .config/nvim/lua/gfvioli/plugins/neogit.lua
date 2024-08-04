return {
    'NeogitOrg/neogit',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-lua/plenary.nvim',         -- required
        'sindrets/diffview.nvim',        -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
        local neogit = require('neogit')

        local keymap = vim.keymap

        keymap.set('n', '<leader>gs', neogit.open, { desc = 'Neo[G]it: [O]pen' })

        keymap.set('n', '<leader>gc', '<cmd>Neogit commit<CR>', { desc = 'Neo[G]it: [C]ommit' })

        keymap.set('n', '<leader>gp', '<cmd>Neogit pull<CR>', { desc = 'Neo[G]it: [P]ull branch' })

        keymap.set('n', '<leader>gP', '<cmd>Neopgit push<CR>', { desc = 'Neo[G]it: [P]ush changes' })

        keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', { desc = 'Neo[G]it: View git [B]ranches' })

        keymap.set('n', '<leader>gB', '<cmd>G blame<CR>', { desc = 'Neo[G]it: Toggle git [B]lame' })
    end
}
