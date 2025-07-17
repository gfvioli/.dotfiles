-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("let g:netrw_liststyle = 3")

-- Setting snacks as the default picker
vim.g.lazyvim_picker = "snacks"

-- Set line numbers
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.laststatus = 3

vim.opt.wrap = true -- disable line wrap

--  search settings
vim.opt.ignorecase = true -- search is case insensitive by default
vim.opt.smartcase = true -- mixed case in search will be made case sensistive
vim.opt.incsearch = true

-- backup and undo opts
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

-- nav settings
vim.opt.scrolloff = 8 -- never more than 8 lines at the end of the file

vim.opt.cursorline = true

vim.opt.termguicolors = true -- turning on termguicolors for tokyonight colorscheme to work
vim.opt.background = "dark" -- colorschemes that can be both light or dark will use the dark mode
vim.opt.signcolumn = "yes" -- show sign column such that text doesn't shift

vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or inset mode start position

-- Uncomment the following line to user the system clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Concealer for Neorg & Obsidian
vim.o.conceallevel = 2

-- Split window behavior
vim.opt.splitright = true -- split window to the right as default
vim.opt.splitbelow = true -- split window bottom as default

-- Securing same clipboard as winodws just in case
vim.g.clipboard = {
  name = "myClipboard",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection primary",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection primary -o",
  },
}

-- setting up default browser
vim.cmd("let g:mkdp_browser = 'msedge.exe'")
