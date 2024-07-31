return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        -- import mason
        local mason = require('mason')

        -- import mason-lspconfig
        local mason_lspconfig = require('mason-lspconfig')

        -- import mason-tool-installer
        local mason_tool_installer = require('mason-tool-installer')

        mason.setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    packa_uninstalled = '✗',
                },
            },
        })

        mason_lspconfig.setup({
            ensure_installed = {
                'rust_analyzer',
                'ruff',
                'lua_ls',
                'pyright',
                'r_language_server',
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                'prettier',
                'stylua',
                'debugpy',
                'mypy',
                'tree-sitter-cli',
                'jupytext',
            },
        })
    end,
}
