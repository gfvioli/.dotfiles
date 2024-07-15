return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer', -- source for text in buffer
        'hrsh7th/cmp-path',   -- source for file system paths
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*', -- Use always latest major release
            build = 'make install_jsregexp'
        },
        'saadparwaiz1/cmp_luasnip',     -- autocompletion
        'rafamadriz/friendly-snippets', -- [supposedly] useful snippets
        'onsails/lspkind.nvim'          -- vscode like pictograms
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
                ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-space>'] = cmp.mapping.complete(), -- show completion suggestions
                ['<C-z>'] = cmp.mapping.abort(),        -- close completion window
                ['<C-y>'] = cmp.mapping.confirm({ select = false })
            }),
            -- source for autocompletion, ORDER MATTERS
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- lsp
                { name = 'luasnip' },  -- snippets
                { name = 'buffer' },   -- text within current buffer
                { name = 'path' },     -- file system path
                { name = 'ruff-lsp' },
                { name = 'otter' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = '...',
                }),
            },
        })
    end,
}
