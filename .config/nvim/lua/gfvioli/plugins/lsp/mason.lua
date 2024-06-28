return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
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
                'ruff',
                'rust_analyzer',
                'ruff_lsp',
                'lua_ls',
                'pyright',
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                'prettier',
                'stylua',
                'ruff',
                'debugpy',
                'mypy',
            },
        })
    end,
}
