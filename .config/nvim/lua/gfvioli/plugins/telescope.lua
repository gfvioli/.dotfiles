return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
        'folke/todo-comments.nvim',
        'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.setup({
            defaults = {
                path_display = { 'smart' },
                mappings = {
                    i = {
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('harpoon')
        telescope.load_extension('git_worktree')
        telescope.load_extension('dap')

        local keymap = vim.keymap

        keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Fuzzy [F]ind [F]iles in cwd' })
        keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy find git files' })
        keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<CR>', { desc = 'Fuzzy [R]ind [R]ecent files' })
        keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<CR>', { desc = 'Fuzzy [F]ind [S]tring in cwd' })
        keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<CR>', { desc = '[F]ind string under [C]ursor in cwd' })
        keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = '[F]ind [T]ODO comments' })
        keymap.set('n', '<leader>fwt', "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            { desc = "[F]ind between [W]ork[T]rees" })
        keymap.set('n', '<leader>cwt', "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
            { desc = "[C]reate new [W]ork[T]ree" })
        keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
            { desc = '[S]earch [N]eovim config files' })
        keymap.set('n', '<leader>/',
            function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end,
            { desc = '[/] Fuzzily search in current buffer' })
        keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open files',
                }
            end,
            { desc = '[S]earch [/] in Open Files' }
        )
        keymap.set('n', '<leader>uc', builtin.colorscheme, { desc = '[U]pdate [C]olorscheme' })
        keymap.set('n', '<leader>fdc', function() require("telescope").extensions.dap.configurations() end,
            { desc = '[F]ind [D]ebug [C]onfiguration' })
    end,
}
