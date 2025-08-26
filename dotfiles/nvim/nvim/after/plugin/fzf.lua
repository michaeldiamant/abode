local fzf = require('fzf-lua')

fzf.setup {
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    }
  }
}

vim.keymap.set('n', '<leader>fg', ":FzfLua live_grep resume=true<cr>", { silent = true })
vim.keymap.set('n', '<leader>ff', ":FzfLua files resume=true<cr>", { silent = true })
vim.keymap.set('n', '<leader>fc', ":FzfLua command_history resume=true<cr>", { silent = true })
vim.keymap.set('n', '<leader>fm', ":FzfLua marks resume=true<cr>", { silent = true })

vim.keymap.set('n', 'cu', ":FzfLua lsp_references<cr>", { silent = true })
vim.keymap.set('n', 'gd', ":FzfLua lsp_definitions<cr>", { silent = true })
vim.keymap.set('n', 'gD', ":FzfLua lsp_typedefs<cr>", { silent = true })
vim.keymap.set('n', '<leader>fs', ":FzfLua lsp_live_workspace_symbols<cr>", { silent = true })
vim.keymap.set('n', '<leader>fS', ":FzfLua lsp_document_symbols<cr>", { silent = true })
