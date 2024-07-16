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
            end,
        }
    },
    config = function()
        local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
        require('dap-python').setup(path)

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
    end,
}
