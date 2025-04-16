-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when copying text",
  group = vim.api.nvim_create_augroup("text-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Remove line numbers from terminal",
  group = vim.api.nvim_create_augroup("terminal-open", { clear = true }),
  callback = function()
    vim.cmd.setlocal("nonumber")
    vim.wo.signcolumn = "no"
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Change concealment characters for Markdown files",
  callback = function()
    vim.cmd([[
            augroup MarkdownSyntaxMatch
            autocmd!
            autocmd FileType markdown syntax match @conceal /```/ conceal cchar=⋯
            augroup END
        ]])
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Change conceallevel to 0 for quarto files",
  group = vim.api.nvim_create_augroup("QuartoEnter", { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype == "quarto" then
      vim.wo.conceallevel = 0
    end
  end,
})
