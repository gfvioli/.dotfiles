return {
    'mfussenegger/nvim-dap',
    ft = 'python',
    dependencies = {
        'mfussenegger/nvim-dap-python',
        'nvim-neotest/nvim-nio',
        'nvim-neotest/neotest',
        'nvim-neotest/neotest-python',
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                local dap = require('dap')
                local dapui = require('dapui')

                dap.listeners.after.event_initialized['dapui_config'] = function()
                    dapui.open()
                end

                dap.listeners.before.event_initialized['dapui_config'] = function()
                    dapui.close()
                end

                dap.listeners.before.event_exited['dapui_config'] = function()
                    dapui.close()
                end

                dapui.setup()

                vim.keymap.set('n', '<leader>dx', function() dapui.close() end, { desc = '[D]ebug Close' })
            end,
        }
    },
    keys = {
        { '<leader>db',  function() require('dap').toggle_breakpoint() end,                                   mode = 'n', desc = 'Toggle [D]ebug [B]reakpoint' },
        { '<Leader>B',   function() require('dap').set_breakpoint() end,                                      mode = 'n', desc = 'Set [D]ebug [B]reakpoint' },
        { '<leader>dpr', function() require("dap-python").test_method() end,                                  mode = 'n', desc = '[D]ebug [P]ython [R]un' },
        { '<leader>dm',  function() require("neotest").run.run() end,                                         mode = 'n', desc = '[D]ebug [M]ethod' },
        { '<leader>dM',  function() require("neotest").run.run({ strategy = "dap" }) end,                     mode = 'n', desc = '[D]ebug [M]ethod DAP' },
        { '<leader>df',  function() require("neotest").run.run({ vim.fn.expand("%") }) end,                   mode = 'n', desc = '[D]ebug [C]lass' },
        { '<leader>dF',  function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, mode = 'n', desc = '[D]ebug [C]lass DAP' },
        { '<leader>dS',  function() require("neotest").summary.toggle() end,                                  mode = 'n', desc = '[D]ebug [S]ummary' },
        { '<leader>dc',  function() require('dap').continue() end,                                            mode = 'n', desc = '[D]ebug [C]ontinue' },
        { '<leader>dso', function() require('dap').step_over() end,                                           mode = 'n', desc = '[D]ebug [S]tep [O]ver' },
        { '<leader>dsi', function() require('dap').step_into() end,                                           mode = 'n', desc = '[D]ebug [S]tep [I]nto' },
        { '<leader>dsx', function() require('dap').step_out() end,                                            mode = 'n', desc = '[D]ebug [S]tep [O]ut' },

    },
    config = function()
        local python_path = vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        require('dap-python').setup(python_path)

        local dap = require('dap')

        require('neotest').setup({
            adapters = {
                require('neotest-python')({
                    dap = {
                        justMyCode = false,
                        console = 'integratedTerminal',
                    },
                    args = { '--log-level', 'DEBUG', '--quiet' },
                    runner = 'pytest',
                })
            }
        })
        dap.configurations.python = {
            {
                name = 'Python Current File',
                type = 'debugpy',
                request = 'launch',
                env = { LOCAL_RUN = "1" },
                program = '${file}',
                pythonPath = function()
                    return python_path
                end
            },
            {
                name = 'dagster-dev',
                type = 'debugpy',
                request = 'launch',
                module = 'dagster',
                args = { 'dev', },
                env = { LOCAL_RUN = "1" },
                subProcess = true,
                pythonPath = function()
                    return vim.fn.getcwd() .. '/.venv/bin/python'
                end,
            }
        }
    end,
}
