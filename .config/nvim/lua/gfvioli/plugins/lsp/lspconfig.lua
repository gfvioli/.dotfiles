return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
        'j-hui/fidget.nvim',
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import cmp_nvim_lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local mason_lspconfig = require('mason-lspconfig')

        local keymap = vim.keymap -- to reduce typing

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings
                -- See `:help vim.lsp.*` for documentation on any of the functions below

                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "[G]et LSP [R]eferences"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                opts.desc = "[G]o to [D]eclaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "[G]o to [D]efinition"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                opts.desc = "[G]o to [I]plementation"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                opts.desc = "[G]o to [T]ype definitions"
                keymap.set("n", "gt", "<cmd>Teslecope lsp_type_definitions<CR>", opts)

                opts.desc = "[C]ode [A]ctions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart [R]e[N]ame"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Buffer [D]iagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                opts.desc = "[D]iagnostics [O]pen float"
                keymap.set("n", "<leader>Do", vim.diagnostic.open_float, opts)

                opts.desc = "Next [D]iagnostics"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                opts.desc = "Previous [D]iagnostics"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "[R]estart [L]SP"
                keymap.set("n", "<leader>rl", "<cmd>LspRestart<CR>", opts)

                opts.desc = '[D]ocument [S]ymbols'
                keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols', opts)
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())

        capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

        -- NOTE: Delete this when new config is battle tested
        -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- end


        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰠠 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
                texthl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarning",
                    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                }
            }
        })

        local function get_quarto_resource_path()
            local function strsplit(s, delimiter)
                local result = {}
                for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
                    table.insert(result, match)
                end
                return result
            end

            local f = assert(io.popen('quarto --paths', 'r'))
            local s = assert(f:read '*a')
            f:close()
            return strsplit(s, '\n')[2]
        end

        local lua_library_files = vim.api.nvim_get_runtime_file('', true)
        local lua_plugin_paths = {}
        local resource_path = get_quarto_resource_path()
        if resource_path == nil then
            vim.notify_once 'quarto not found, lua library files not loaded'
        else
            table.insert(lua_library_files, resource_path .. '/lua-types')
            table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
        end

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ['lua_ls'] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                                disable = { 'missing-fields' },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,

            ['ruff'] = function()
                lspconfig.ruff.setup({
                    capabilities = capabilities,
                    init_options = {
                        settings = {
                            -- Any extra CLI arguments for `ruff` go here.
                            args = {
                                organizeImports = true,
                            },
                        }
                    }
                })
            end,

            ['pyright'] = function()
                lspconfig.pyright.setup({
                    capabilities = capabilities,
                    settings = {
                        pyright = {
                            disableOrganizeImports = true,
                            disableTaggedHints = true,
                        },
                        python = {
                            analysis = {
                                ignore = ({ '*' }),
                                -- typeCheckingMode = 'off',
                            }
                        }
                    }
                })
            end,

            ['r_language_server'] = function()
                lspconfig.r_language_server.setup({
                    capabilities = capabilities,
                    settings = {
                        r = {
                            lsp = {
                                rich_documentation = false,
                            }
                        }
                    }
                })
            end,
        })
    end,
}
