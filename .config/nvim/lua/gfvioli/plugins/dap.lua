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
            end,
        }
    },
    config = function()
        local python_path = vim.fn.expand('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        require('dap-python').setup(python_path)

        local dap = require('dap')

        local keymap = vim.keymap
        keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint<cr>', { desc = '[D]ebug [B]reakpoint' })
        keymap.set('n', '<leader>dpr', function() require('dap-python').test_method() end,
            { desc = '[D]ebug [P]ython [R]un' })

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
            },
            log_level = vim.log.levels.INFO,
            consumers = {},
            icons = {
                passed = "✔",
                running = "🗘",
                failed = "✖",
                skipped = "ﰸ",
                unknown = "?"
            },
            highlights = {
                adapter_name = "NeotestAdapterName",
                dir = "NeotestDir",
                expand_marker = "NeotestExpandMarker",
                failed = "NeotestFailed",
                file = "NeotestFile",
                focused = "NeotestFocused",
                indent = "NeotestIndent",
                marked = "NeotestMarked",
                namespace = "NeotestNamespace",
                passed = "NeotestPassed",
                running = "NeotestRunning",
                select_win = "NeotestSelectWin",
                skipped = "NeotestSkipped",
                target = "NeotestTarget",
                test = "NeotestTest",
                unknown = "NeotestUnknown"
            },
            floating = {
                border = "rounded",
                max_height = 0.9,
                max_width = 0.9,
                options = {}
            },
            strategies = {
                integrated = {
                    runner = "neotest",
                    options = {},
                    width = 80,
                }
            },
            run = {
                enabled = true
            },
            summary = {
                enabled = true,
                animated = true,
                expand_errors = true,
                follow = true,
                open = "botright split | resize 30",
                mappings = {
                    attach = "a",
                    clear_marked = "M",
                    clear_target = "T",
                    debug = "d",
                    debug_marked = "D",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    expand_all = "e",
                    jumpto = "i",
                    mark = "m",
                    next_failed = "J",
                    output = "o",
                    prev_failed = "K",
                    run = "r",
                    run_marked = "R",
                    short = "O",
                    stop = "u",
                    target = "t",
                    watch = "w"
                }
            },
            output = {
                enabled = true,
                open_on_run = "short",
            },
            output_panel = {
                enabled = true,
                open = "botright split | resize 15",
            },
            quickfix = {
                enabled = true,
                open = false,
            },
            status = {
                enabled = true,
                signs = true,
                virtual_text = false,
            },
            state = {
                enabled = true,
            },
            watch = {
                enabled = true,
                args = { "tests", "watch" },
                symbol_queries = {
                    python = [[
                        (function_definition
                            name:(identifier) @function)
                        (class_definition
                            name:(identifier) @class)
                    ]]
                }
            },
            diagnostic = {
                enabled = true,
                severity = vim.diagnostic.severity.ERROR,
            },
            projects = {},
        })

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch File',
                program = '${file}',
                pythonPath = function()
                    return python_path
                end
            }
        }
    end,
}
