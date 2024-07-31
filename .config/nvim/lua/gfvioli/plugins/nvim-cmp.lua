return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',                -- source for builtin lsp client
        'hrsh7th/cmp-calc',                    -- source for math
        'hrsh7th/cmp-buffer',                  -- source for text in buffer
        'hrsh7th/cmp-path',                    -- source for file system paths
        'hrsh7th/cmp-emoji',                   -- source for emojies
        'hrsh7th/cmp-nvim-lsp-signature-help', -- for function signature help
        'saadparwaiz1/cmp_luasnip',            -- autocompletion
        'rafamadriz/friendly-snippets',        -- [supposedly] useful snippets
        'onsails/lspkind.nvim',                -- vscode like pictograms
        'kdheepak/cmp-latex-symbols',          -- for latex
        'jmbuhr/cmp-pandoc-references',        -- for bibliography, reference and cross-ref items
        'jmbuhr/otter.nvim',                   -- for syntax highlight and autocompletion inside quarto files
        'ray-x/cmp-treesitter',                --
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*', -- Use always latest major release
            build = 'make install_jsregexp'
        },
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }

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

            -- NOTE:source for autocompletion, ORDER MATTERS

            sources = cmp.config.sources({
                { name = 'otter' },                                                          -- quarto
                { name = 'path' },                                                           -- file system path
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },                                                       -- lsp
                { name = 'luasnip',                keyword_length = 3, max_item_count = 3 }, -- snippets
                { name = 'pandoc_references' },
                { name = 'buffer',                 keyword_length = 5, max_item_count = 3 }, -- text within current buffer
                { name = 'spell' },
                { name = 'treesitter',             keyword_length = 5, max_item_count = 3 },
                { name = 'calc' },
                { name = 'latex_symbols' },
                { name = 'emoji' },

            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = '...',
                }),
            },
        })

    --     luasnip.filetype_extend('quarto', { 'markdown' })
    --     luasnip.filetype_extend('rmarkdown', { 'markdown' })
    end,
}
