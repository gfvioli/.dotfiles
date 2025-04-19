return {
  "folke/snacks.nvim",
  opts = {
    matcher = {
      frecency = true,
      cwd_bonus = true,
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<a-i>"] = { { "toggle_hidden", "toggle_ignored" }, mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
