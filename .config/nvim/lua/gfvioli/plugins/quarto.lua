-- Defining helper functions
return {
    {
        'quarto-dev/quarto-nvim',
        dependencies = {
            {
                'jmbuhr/otter.nvim',
                opts = {},
                dev = false,
                dependencies = {
                    'neovim/nvim-lspconfig',
                    'nvim-treesitter/nvim-treesitter',
                },
                config = function()
                    local function get_otter_symbols_lang()
                        local otterkeeper = require 'otter.keeper'
                        local main_nr = vim.api.nvim_get_current_buf()
                        local langs = {}
                        for i, l in ipairs(otterkeeper.rafts[main_nr].languages) do
                            langs[i] = i .. ': ' .. l
                        end
                        -- promt to choose one of langs
                        local i = vim.fn.inputlist(langs)
                        local lang = otterkeeper.rafts[main_nr].languages[i]
                        local params = {
                            textDocument = vim.lsp.util.make_text_document_params(),
                            otter = {
                                lang = lang
                            }
                        }
                        -- don't pass a handler, as we want otter to use it's own handlers
                        vim.lsp.buf_request(main_nr, vim.lsp.protocol.Methods.textDocument_documentSymbol, params, nil)
                    end

                    vim.keymap.set("n", "<leader>os", get_otter_symbols_lang, { desc = "[O]tter [S]ymbols" })
                    vim.keymap.set("n", "<leader>oe", function() require('otter').export(true) end,
                        { desc = "[O]tter [E]xport with overwrite" })
                    vim.keymap.set("n", "<leader>oa", function() require("otter").activate() end,
                        { desc = "[O]tter [A]ctivate" })
                    vim.keymap.set('n', '<leader>ok', function() require('otter').deactivate() end,
                        { desc = "[O]tter [K]ill" })
                end,
            },
        },
        ft = { 'quarto' },
        dev = false,
        config = function()
            require('quarto').setup({
                lspFeatures = {
                    enabled = true,
                    languages = { 'python', 'r', 'julia', 'lua' },
                    diagnostics = {
                        enabled = true,
                        triggers = { 'BufWrite' },
                    },
                    completion = {
                        enabled = true,
                    },
                }
            })

            vim.keymap.set('n', '<leader>qm', 'O# %%<CR>', { desc = 'Insert [Q]uarto [M]agic' })
            vim.keymap.set('n', '<leader>qra', '<cmd>QuartoSendAbove<cr>', { desc = '[Q]uarto [R]un [A]bove' })
            vim.keymap.set('n', '<leader>qre', '<cmd>QuartoSendAll<cr>', { desc = '[Q]uarto [R]un [E]verything' })
            vim.keymap.set('n', '<leader>qrb', '<cmd>QuartoSendBelow<cr>', { desc = '[Q]uarto [R]un [B]elow' })
            vim.keymap.set('n', '<leader>qa', '<cmd>QuartoActivate<cr>', { desc = '[Q]uarto [A]ctivate' })
            vim.keymap.set('n', '<leader>qp', '<cmd>QuartoPreview<cr>', { desc = '[Q]uarto [P]review' })
            vim.keymap.set('n', '<leader>qx', '<cmd>QuartoClosePreview<cr>', { desc = '[Q]uarto Preview' })
        end,
    },
    { --directly open ipynb files as quarto docuements and convert back behind the scenes
        'GCBallesteros/jupytext.nvim',
        opts = {
            custom_language_formatting = {
                python = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
                r = {
                    extension = 'qmd',
                    style = 'quarto',
                    force_ft = 'quarto',
                },
            },
        },
    },
    { -- send code from python/r/qmd documets to a terminal or REPL like ipython, R, bash
        'jpalardy/vim-slime',
        dev = false,
        init = function()
            vim.b['quarto_is_python_chunk'] = false
            Quarto_is_in_python_chunk = function()
                require('otter.tools.functions').is_otter_language_context 'python'
            end

            vim.cmd [[
                let g:slime_dispatch_ipython_pause = 100
                function SlimeOverride_EscapeText_quarto(text)
                    call v:lua.Quarto_is_in_python_chunk()
                        if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
                            return [g:slime_dispatch_ipython_pause, a:text, "", "\n"]
                        else
                        if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
                            return [a:text, "\n"]
                        else
                            return [a:text]
                        end
                    end
                endfunction
            ]]

            vim.g.slime_target = 'neovim'
            vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
            vim.g.slime_dispatch_ipython_pause = 100
        end,
        config = function()
            vim.g.slime_input_pid = false
            vim.g.slime_suggest_default = true
            vim.g.slime_menu_config = false
            vim.g.slime_neovim_ignore_unlisted = true


            local function mark_terminal()
                local job_id = vim.b.terminal_job_id
                vim.print('job_id: ' .. job_id)
            end

            local function set_terminal()
                vim.fn.call('slime#config', {})
            end
            vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[C]ode: [M]ark terminal' })
            vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[C]ode: [S]et terminal' })


            vim.g['quarto_is_r_mode'] = nil
            vim.g['reticulate_running'] = false

            local function send_cell()
                if vim.b['quarto_is_r_mode'] == nil then
                    vim.fn['slime#send_cell']()
                    return
                end
                if vim.b['quarto_is_r_mode'] == true then
                    vim.g.slime_python_ipython = 0
                    local is_python = require('otter.tools.functions').is_otter_language_context 'python'
                    if is_python and not vim.b['reticulate_running'] then
                        vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
                        vim.b['reticulate_running'] = true
                    end
                    if not is_python and vim.b['reticulate_running'] then
                        vim.fn['slime#send']('exit' .. '\r')
                        vim.b['reticulate_running'] = false
                    end
                    vim.fn['slime#send_cell']()
                end
            end

            local slime_send_region_cmd = '<cmd><C-u>call slime#send_op(visualmode(), 1)<CR>'
            local function send_region()
                -- if filetyps is not quarto, just send_region
                if vim.bo.filetype ~= 'quarto' or vim.b['quarto_is_r_mode'] == nil then
                    vim.cmd('normal' .. slime_send_region_cmd)
                    return
                end
                if vim.b['quarto_is_r_mode'] == true then
                    vim.g.slime_python_ipython = 0
                    local is_python = require('otter.tools.functions').is_otter_language_context 'python'
                    if is_python and not vim.b['reticulate_running'] then
                        vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
                        vim.b['reticulate_running'] = true
                    end
                    if not is_python and vim.b['reticulate_running'] then
                        vim.fn['slime#send']('exit' .. '\r')
                        vim.b['reticulate_running'] = false
                    end
                    vim.cmd('normal' .. slime_send_region_cmd)
                end
            end

            vim.keymap.set({ 'n', 'i' }, '<leader><CR>', send_cell, { desc = 'Send code to terminal' })
            vim.keymap.set('v', '<leader><CR>', send_region, { desc = 'Send code to terminal' })
        end,
    },
    { -- preview equations
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>qm', '<cmd>lua require("nabla").toggle_virt()<cr>', desc = '[Q]uarto: toggle [M]ath equations' }
        }
    },
    { -- paste an image from the clipboard or drag-and-drop
        'HakonHarnes/img-clip.nvim',
        event = 'BufEnter',
        ft = { 'markdown', 'quarto', 'latex' },
        opts = {
            default = {
                dir_path = 'img',
            },
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
                quarto = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
            },
        },
        config = function(_, opts)
            require('img-clip').setup(opts)
            vim.keymap.set('n', '<leader>ii', '<cmd>PasteImage<cr>', { desc = '[I]nsert [I]mage from clipboard' })
        end,
    },
    {
        'benlubas/molten-nvim',
        enabled = false,
        build = '<cmd>UpdateRemotePlugins',
        init = function()
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
        end,
        keys = {
            { '<leader>mi', '<cmd>MoltenInit<cr>',           mode = 'n', desc = '[M]olten [I]nit' },
            {
                '<leader>me',
                '<cmd><C-u>MoltenEvaluateVisual<cr>',
                mode = 'v',
                desc = '[M]olten [E]val visual',
            },
            { '<leader>mr', '<cmd>MoltenReevaluateCell<cr>', mode = 'n', desc = '[M]olten [R]e-eval cell' },
        },
    },
}
