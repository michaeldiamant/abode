local hurl = require("hurl")
hurl.setup({
  auto_close = false,
  debug = false,
  show_notification = false,
  mode = "split", -- "split" or "popup"
  formatters = {
    json = { "jq" },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "hurl",
  callback = function()
    -- Run ALL API requests in the file
    vim.keymap.set("n", "<leader>hA", "<cmd>HurlRunner<CR>")

    -- Run ONLY the API request under your cursor
    vim.keymap.set("n", "<leader>ha", "<cmd>HurlRunnerAt<CR>")

    -- Run request from start down to current line
    vim.keymap.set("n", "<leader>he", "<cmd>HurlRunnerToEntry<CR>")

    -- Toggle between split view and popup display
    vim.keymap.set("n", "<leader>htm", "<cmd>HurlToggleMode<CR>")

    vim.keymap.set("n", "<leader>hl", "<cmd>HurlShowLastResponse<CR>")
    vim.keymap.set("n", "<leader>hv", "<cmd>HurlVerbose<CR>")
  end,
})
