local insert_mode = "i"
local normal_mode = "n"
local term_mode = "t"
local visual_mode = "v"
local visual_block_mode = "x"
local command_mode = "c"

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ normal_mode, visual_mode }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set(normal_mode, '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set(normal_mode, '<leader>sn', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set(normal_mode, '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set(normal_mode, 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set(normal_mode, '<C-d>', '<C-d>zz', opts)
vim.keymap.set(normal_mode, '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set(normal_mode, "n", 'nzzzv', opts)
vim.keymap.set(normal_mode, "N", 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set(normal_mode, '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set(normal_mode, '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set(normal_mode, '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set(normal_mode, '<C-Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set(normal_mode, '<Tab>', ':bnext<CR>', opts)
vim.keymap.set(normal_mode, '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set(normal_mode, '<leader>c', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set(normal_mode, '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set(normal_mode, '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set(normal_mode, '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set(normal_mode, '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set(normal_mode, '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set(normal_mode, '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set(normal_mode, '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set(normal_mode, '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set(normal_mode, '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set(normal_mode, '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set(normal_mode, '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set(normal_mode, '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set(normal_mode, '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set(normal_mode, '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set(visual_mode, '<', '<gv', opts)
vim.keymap.set(visual_mode, '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set(visual_mode, 'p', '"_dP', opts)

opts.desc = "Forward quick fix list"
vim.keymap.set(normal_mode, "<C-k>", "<cmd>cnext<CR>zz", opts)
opts.desc = "Backword quick fix list"
vim.keymap.set(normal_mode, "<C-j>", "<cmd>cprev<CR>zz", opts)
opts.desc = "Forward location list"
vim.keymap.set(normal_mode, "<leader>k", "<cmd>lnext<CR>zz", opts)
opts.desc = "Backward location list"
vim.keymap.set(normal_mode, "<leader>j", "<cmd>lprev<CR>zz", opts)

opts.desc = "Search and replace current word"
vim.keymap.set(normal_mode, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
opts.desc = "Set execute on file"
vim.keymap.set(normal_mode, "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, opts)

opts.desc = "Source file"
vim.keymap.set(normal_mode, "<leader><leader>", function()
  vim.cmd("source %")
end)

opts.desc = "Move line down while in visual mode"
vim.keymap.set(visual_mode, "J", ":m '>+1<CR>gv=gv")
opts.desc = "Move line up while in visual mode"
vim.keymap.set(visual_mode, "K", ":m '<-2<CR>gv=gv")
opts.desc = "Swap line down while in visual mode"
vim.keymap.set(visual_mode, "<A-j>", ":m .+1<CR>==", opts)
opts.desc = "Swap line up while in visual mode"
vim.keymap.set(visual_mode, "<A-k>", ":m .-2<CR>==", opts)

-- next greatest remap ever : asbjornHaland
opts.desc = "Yank line text"
vim.keymap.set({normal_mode, visual_mode}, "<leader>y", [["+y]])
opts.desc = "Yank line text"
vim.keymap.set(normal_mode, "<leader>Y", [["+Y]])

-- Insert blank line above and below current line
opts.desc = "Insert line below current line"
vim.keymap.set(normal_mode, "<leader>o", "m`o<Esc>``", opts)
opts.desc = "Insert line above current line"
vim.keymap.set(normal_mode, "<leader>O", "m`O<Esc>``", opts)

opts.desc = "Cut text"
vim.keymap.set({normal_mode, visual_mode}, "<leader>d", "\"_d")

-- This is going to get me cancelled
opts.desc = "Escape out of insert mode"
vim.keymap.set(insert_mode, "<C-c>", "<Esc>")

-- Diagnostic keymaps
vim.keymap.set(normal_mode, '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set(normal_mode, ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set(normal_mode, '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set(normal_mode, '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

opts.desc = ""
vim.keymap.set(normal_mode, "<left>",  ":echohl WarningMsg<Bar>echo 'USE h to move left!'<Bar>echohl None<CR>", opts)
vim.keymap.set(normal_mode, "<right>", ":echohl WarningMsg<Bar>echo 'USE l to move right!'<Bar>echohl None<CR>", opts)
vim.keymap.set(normal_mode, "<up>",    ":echohl WarningMsg<Bar>echo 'USE k to move up!'<Bar>echohl None<CR>", opts)
vim.keymap.set(normal_mode, "<down>",  ":echohl WarningMsg<Bar>echo 'USE j to move down!'<Bar>echohl None<CR>", opts)
vim.keymap.set(insert_mode, "<left>",  "<C-o>:echohl WarningMsg<Bar>echo 'USE h to move left!'<Bar>echohl None<CR>", opts)
vim.keymap.set(insert_mode, "<right>", "<C-o>:echohl WarningMsg<Bar>echo 'USE l to move right!'<Bar>echohl None<CR>", opts)
vim.keymap.set(insert_mode, "<up>", "<C-o>:echohl WarningMsg<Bar>echo 'USE k to move up!'<Bar>echohl None<CR>", opts)
vim.keymap.set(insert_mode, "<down>", "<C-o>:echohl WarningMsg<Bar>echo 'USE j to move down!'<Bar>echohl None<CR>", opts)