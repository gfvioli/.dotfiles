vim.g.mapleader = ' '

local keymap = vim.keymap -- to decrease amount of typing

-- Basic rebinds
keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode with jk' })
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })
keymap.set('x', '<leader>p', '\"_dP', { desc = 'Paste without loosing current paste buffer' })
keymap.set('n', '<leader>y', '\"+y', { desc = 'Copy to system register' })
keymap.set('v', '<leader>y', '\"+y', { desc = 'Copy to system register' })
keymap.set('n', '<leader>Y', '\"+Y', { desc = 'Copy to system register' })
keymap.set('n', '<leader>d', '\"_d', { desc = 'Delete into void register' })
keymap.set('v', '<leader>d', '\"_d', { desc = 'Delete into void register' })
keymap.set('n', '<leader><leader>', function() vim.cmd('so') end, { desc = 'Source current file' })
keymap.set('n', '<leader>ex', '<cmd>!chmod +x %<CR>', { desc = 'Make current file executable' })

-- Quick fix navigation
keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Quick fix next' })
keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Quic fix prev' })
keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'List next' })
keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'List prev' })

-- Replacement
keymap.set('n', '<leader>cw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Change current word' })

-- Movement
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
keymap.set('n', 'J', 'mzJ`z', { desc = 'Move line below to the end of the line, cursor inplace' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page-up and centered' })
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page-up and centered' })
keymap.set('n', 'n', 'nzzzv', { desc = 'Next search term and centered' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search term and centered' })

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split' })

-- Tab management
keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' })
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' })
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' })
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })

-- Jupyter notebook remaps
keymap.set({ 'n', 'i' }, '<m-i>', '<esc>i```{python}<cr>```<esc>0', { desc = '[I]nsert chunk code' })
keymap.set('n', '<leader>ci', ':vsplit term://ipython<cr>', { desc = '[C]reate [I]Python terminal' })
