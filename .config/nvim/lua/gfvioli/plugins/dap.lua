return {
    'mfussenegger/nvim-dap',
    ft = 'python',
    dependencies = {
        'mfussenegger/nvim-dap-python',
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                local dap = require('dap')
                local dapui = require('dapui')

                dapui.setup()
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
    end,
}
