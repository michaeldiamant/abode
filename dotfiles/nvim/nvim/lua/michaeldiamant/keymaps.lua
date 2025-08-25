vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<C-y>", [["+y]])
vim.keymap.set("n", "<C-Y>", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-s>k", ":resize -3<CR>")
vim.keymap.set("n", "<C-s>j", ":resize +3<CR>")
vim.keymap.set("n", "<C-s>h", ":vertical resize -3<CR>")
vim.keymap.set("n", "<C-s>l", ":vertical resize +3<CR>")

-- In termnal buffers, make it easier to enter normal mode
vim.keymap.set('t', "n", "<C-\\><C-N>")

vim.keymap.set("n", "gt", ":NERDTreeFind<CR><C-w>|")
vim.keymap.set("n", "gT", ":NERDTree<CR><C-w>|")

vim.keymap.set("n", "\\j", ":%! python -m json.tool<CR>")
vim.keymap.set('n', '<leader>vl', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = not current })
end, { desc = 'Toggle diagnostic virtual_lines' })

