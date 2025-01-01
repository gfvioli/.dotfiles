return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        -- { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
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

        keymap.set('n', '<leader>ff',
            function() builtin.find_files { file_ignore_patterns = { '^explorations/' }, prompt_title = 'Find Files excl. explorations' } end,
            { desc = 'Fuzzy [F]ind [F]iles in cwd excl. explorations' })
        keymap.set('n', '<leader>fe',
            function() builtin.find_files { prompt_title = '[F]ind [F]iles in cwd incl. explorations' } end,
            { desc = 'Fuzzy [F]ind [F]iles in cwd incl. [E]xplorations' })
        keymap.set('n', '<leader>fE',
            function() builtin.find_files { cwd = vim.fn.getcwd() .. '/explorations/', prompt_title = 'Find Files in explorations' } end,
            { desc = 'Fuzzy [F]ind [F]iles in [E]xplorations folder' })
        keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Fuzzy [F]ind [G]it files' })
        keymap.set('n', '<leader>fb', builtin.git_branches, { desc = 'Fuzzy [F]ind [G]it [B]ranches' })
        keymap.set('n', '<leader>fp', builtin.pickers, { desc = 'Fuzzy [F]ind [P]ickers' })
        keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Fuzzy [F]ind [R]ecent files' })
        keymap.set('n', '<leader>fR', builtin.registers, { desc = '[F]ind in [R]egisters' })
        keymap.set('n', '<leader>fh', builtin.highlights, { desc = 'Fuzzy [F]ind [H]ighlights' })
        keymap.set('n', '<leader>fs', function()
                builtin.live_grep { file_ignore_patterns = { '^explorations/' }, prompt_title = 'Find string excl. explorations' }
            end,
            { desc = 'Fuzzy [F]ind [S]tring in cwd excl. explorations' })
        keymap.set('n', '<leader>fS',
            function() builtin.live_grep { prompt_title = 'Find string incl. explorations' } end,
            { desc = 'Fuzzy [F]ind [S]tring in cwd incl. explorations' })
        keymap.set('n', '<leader>fc',
            function() builtin.grep_string { file_ignore_patterns = { '^explorations/' }, prompt_title = 'Find string under cursor excl. explorations' } end,
            { desc = '[F]ind string under [C]ursor in cwd excl. explorations' })
        keymap.set('n', '<leader>fC',
            function() builtin.grep_string { prompt_title = '[F]ind [F]iles in cwd incl. explorations' } end,
            { desc = '[F]ind string under [C]ursor in cwd incl. explorations' })
        keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = '[F]ind [T]ODO comments' })
        keymap.set('n', '<leader>fws', telescope.extensions.git_worktree.git_worktrees,
            { desc = "[F]ind between [W]orktrees" })
        keymap.set('n', '<leader>fwn', telescope.extensions.git_worktree.create_git_worktree,
            { desc = "[F]ind [W]orktree [N]ew" })
        keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
        keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        keymap.set('n', '<leader>sa', builtin.autocommands, { desc = '[S]earch [A]utocommands' })
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
        keymap.set('n', '<leader>fdc', function() telescope.extensions.dap.configurations() end,
            { desc = '[F]ind [D]ebug [C]onfiguration' })
    end,
}
