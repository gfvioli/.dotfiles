vim.cmd("let g:netrw_liststyle = 3")

-- Set line numbers
vim.opt.relativenumber = true
vim.opt.number         = true

vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.autoindent     = true
vim.opt.smartindent    = true

vim.opt.wrap           = false -- disable line wrap

--  search settings
vim.opt.ignorecase     = true -- search is case insensitive by default
vim.opt.smartcase      = true -- mixed case in search will be made case sensistive
vim.opt.incsearch      = true

-- backup and undo opts
vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.undodir        = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile       = true

-- nav settings
vim.opt.scrolloff      = 8 -- never more than 8 lines at the end of the file

vim.opt.cursorline     = true

vim.opt.termguicolors  = true               -- turning on termguicolors for tokyonight colorscheme to work
vim.opt.background     = "dark"             -- colorschemes that can be both light or dark will use the dark mode
vim.opt.signcolumn     = "yes"              -- show sign column such that text doesn't shift

vim.opt.backspace      = "indent,eol,start" -- allow backspace on indent, end of line or inset mode start position

-- Uncomment the following line to user the system clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Concealer for Neorg & Obsidian
vim.o.conceallevel = 2

-- Split window behavior
vim.opt.splitright = true -- split window to the right as default
vim.opt.splitbelow = true -- split window bottom as default

-- auto commands
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when copying text',
    group = vim.api.nvim_create_augroup('text-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Remove line numbers from terminal',
    group = vim.api.nvim_create_augroup('terminal-open', { clear = true }),
    callback = function()
        vim.cmd.setlocal 'nonumber'
        vim.wo.signcolumn = 'no'
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { buffer = 0 })
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { buffer = 0 })
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { buffer = 0 })
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { buffer = 0 })
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Change concealment characters for Markdown files',
    callback = function()
        vim.cmd [[
            augroup MarkdownSyntaxMatch
            autocmd!
            autocmd FileType markdown syntax match @conceal /```/ conceal cchar=⋯
            augroup END
        ]]
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Change conceallevel to 0 for quarto files',
    group = vim.api.nvim_create_augroup('QuartoEnter', { clear = true }),
    callback = function(opts)
        if vim.bo[opts.buf].filetype == 'quarto' then
            vim.wo.conceallevel = 0
        end
    end,
})
