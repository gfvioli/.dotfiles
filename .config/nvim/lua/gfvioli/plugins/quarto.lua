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
                }
            },
        },
        ft = { 'quarto' },
        dev = false,
        config = function()
            require('quarto').setup({
                lspFeatures = {
                    enabled = true,
                    languages = { 'python', 'r' },
                    diagnostics = {
                        enabled = true,
                        triggers = { 'BufWrite' }
                    },
                    completion = {
                        enabled = true
                    },
                }
            })
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
            -- vim.b['quarto_is_python_chunk'] = false
            -- Quarto_is_in_python_chunk = function()
            --     require('otter.tools.functions').is_otter_language_context 'python'
            -- end
            --
            -- vim.cmd [[
            --    let g:slime_dispatch_ipython_pause = 100
            --    function SlimeOverride_EscapeText_quarto(text)
            --    call v:lua.Quarto_is_in_python_chunk()
            --    if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
            --    return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "", "\n"]
            --    else
            --    if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
            --    return [a:text, "\n"]
            --    else
            --    return [a:text]
            --    end
            --    end
            --    endfunction
            --    ]]

            vim.g.slime_target = 'neovim'
            -- vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
            vim.g.slime_dispatch_ipython_pause = 100
            vim.g.slime_cell_delimiter = '# \\s\\=%%'

            vim.cmd [[
            function! _EscapeText_python(text)
              if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
                return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
              else
                let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
                let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
                let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
                let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
                let except_pat = '\(elif\|else\|except\|finally\)\@!'
                let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
                return substitute(dedented_lines, add_eol_pat, "\n", "g")
              end
            endfunction
            ]]
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
            vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
            vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
            vim.keymap.set('n', '<leader>qs', function() vim.cmd [[ call slime#send_cell() ]] end,
                { desc = 'Send code to terminal' })
        end,
    },
    { -- preview equations
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>qm', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle [M]ath equations' }
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
            vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = '[I]nsert [I]mage from clipboard' })
        end,
    },
    {
        'benlubas/molten-nvim',
        enabled = false,
        build = ':UpdateRemotePlugins',
        init = function()
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
        end,
        keys = {
            { '<leader>mi', ':MoltenInit<cr>',           desc = '[M]olten [I]nit' },
            {
                '<leader>mv',
                ':<C-u>MoltenEvaluateVisual<cr>',
                mode = 'v',
                desc = 'molten eval visual',
            },
            { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = '[M]olten [R]e-eval cell' },
        },
    },
}
