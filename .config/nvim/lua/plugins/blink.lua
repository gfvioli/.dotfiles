return {
  "saghen/blink.cmp",
  opts = {
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
