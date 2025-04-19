return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    "jmbuhr/otter.nvim", -- for syntax highlight and autocompletion inside quarto files
    "jmbuhr/cmp-pandoc-references", -- for bibliography
    "moyiz/blink-emoji.nvim",
    {
      "saghen/blink.compat",
      opts = {},
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },

  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "omni", "emoji" },
      compat = { "pandoc_references" },
      providers = {
        emoji = {
          module = "blink-emoji",

          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          -- should_show_items = function()
          --   -- Enable emoji completion only for git commits and markdown.
          --   -- By default, enabled for all file-types.
          --   return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
          -- end,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true }, -- experimental, use lsp-signature-help if doesn't work properly
    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" }, -- previous suggestion
      ["<C-j>"] = { "select_next", "fallback" }, -- next suggestion
      ["<Tab>"] = { "select_prev", "fallback" }, -- previous suggestion
      ["<S-Tab>"] = { "select_next", "fallback" }, -- next suggestion
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-space>"] = { "show", "fallback" }, -- show completion suggestions
      ["<S-CR>"] = { "hide", "fallback" }, -- close completion window
      ["<C-y>"] = { "select_and_accept", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
    },
  },
}
