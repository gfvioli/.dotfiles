return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim',         -- required
        'sindrets/diffview.nvim',        -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
    },
    config = function()
        local neogit = require('neogit')

        local keymap = vim.keymap

        keymap.set('n', '<leader>gs', neogit.open, { desc = 'Open Neogit' })

        keymap.set('n', '<leader>gc', ':Neogit commit<CR>', { desc = 'Commit changes' })

        keymap.set('n', '<leader>gp', ':Neogit pull<CR>', { desc = 'Pull branch' })

        keymap.set('n', '<leader>gP', ':Neopgit push<CR>', { desc = 'Push changes' })

        keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { desc = 'View git branches' })

        keymap.set('n', '<leader>gB', ':G blame<CR>', { desc = 'Toggle git blame' })
    end
}
