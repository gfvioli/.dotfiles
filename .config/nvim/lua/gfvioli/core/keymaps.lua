vim.g.mapleader = ' '

local keymap = vim.keymap -- to decrease amount of typing

-- Basic rebinds
keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode with jk' })
keymap.set('v', '>', '>gv', { desc = 'Keep selection after indenting' })
keymap.set('v', '<', '<gv', { desc = 'Keep selection after de-indenting' })
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })
keymap.set('n', '<leader><leader>', function() vim.cmd('so') end, { desc = 'Source current file' })
keymap.set('n', '<leader>ex', '<cmd>!chmod +x %<CR>', { desc = 'Make current file executable' })
keymap.set('x', '<leader>p', '\"_dP', { desc = 'Paste without loosing current paste register' })
keymap.set('n', '<leader>Y', '\"+Y', { desc = 'Copy to system register' })
keymap.set({ 'n', 'v' }, '<leader>d', '\"_d', { desc = 'Delete into void register' })
keymap.set({ 'n', 'v' }, '<leader>y', '\"+y', { desc = 'Copy to system register' })

-- Quick fix navigation
keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Quick fix next' })
keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Quic fix prev' })
keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'List next' })
keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'List prev' })

-- Replacement
keymap.set('n', '<leader>cw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
    { desc = '[C]hange current [W]ord' })

-- Movement
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
keymap.set('n', 'J', 'mzJ`z', { desc = 'Move line below to the end of the line, cursor inplace' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page-up and centered' })
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page-up and centered' })
keymap.set('n', 'n', 'nzzzv', { desc = 'Next search term and centered' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search term and centered' })

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = '[S]plit: [V]ertically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = '[S]plit: [H]orizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = '[S]plit: Make them [E]qual' })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = '[S]plit: Close [X]' })

-- Tab management
keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = '[T]ab: [O]pen new' })
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = '[T]ab: Close [X]' })
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = '[T]ab: [N]ext' })
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = '[T]ab: [P]revious' })
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = '[T]ab: [C]urrent in new buffer' })

-- Quarto/DS workwflow
local is_code_chunk = function()
    local current, _ = require('otter.keeper').get_current_language_context()
    if current then
        return true
    else
        return false
    end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
    local keys
    if is_code_chunk() then
        keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
    else
        keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
    end
    keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_r_chunk = function()
    insert_code_chunk 'r'
end

local insert_py_chunk = function()
    insert_code_chunk 'python'
end

local insert_lua_chunk = function()
    insert_code_chunk 'lua'
end

local insert_julia_chunk = function()
    insert_code_chunk 'julia'
end

local insert_bash_chunk = function()
    insert_code_chunk 'bash'
end

keymap.set('n', '<leader>ip', insert_py_chunk, { desc = '[I]nsert [P]ython chunk' })
keymap.set('n', '<leader>ir', insert_r_chunk, { desc = '[I]nsert [R] chunk' })
keymap.set('n', '<leader>ij', insert_julia_chunk, { desc = '[I]nsert [J]ulia chunk' })
keymap.set('n', '<leader>il', insert_lua_chunk, { desc = '[I]nsert [L]ua chunk' })
keymap.set('n', '<leader>ib', insert_bash_chunk, { desc = '[I]nsert [B]ash chunk' })

local function new_terminal(lang)
    vim.cmd('vsplit term://' .. lang)
end

local function new_terminal_python()
    new_terminal 'ipython --no-confirm-exit --matplotlib --nosep --no-banner --automagic --classic'
end

local function new_terminal_r()
    new_terminal 'R --no-save'
end

local function new_terminal_ipython()
    new_terminal 'ipython --no-confirm-exit --matplotlib --nosep --no-banner --automagic'
end

local function new_terminal_julia()
    new_terminal 'julia'
end

local function new_terminal_shell()
    new_terminal '$SHELL'
end

-- new terminals keymaps
keymap.set('n', '<leader>cp', new_terminal_python, { desc = '[C]ode [P]ython' }) -- less clear than the iPython one
keymap.set('n', '<leader>ci', new_terminal_ipython, { desc = '[C]ode [I]Python' })
keymap.set('n', '<leader>cr', new_terminal_r, { desc = '[C]ode [R]' })
keymap.set('n', '<leader>cj', new_terminal_julia, { desc = '[C]ode [J]ulia' })
keymap.set('n', '<leader>ct', new_terminal_shell, { desc = '[C]ode [T]erminal' })
