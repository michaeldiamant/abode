require("no-neck-pain").setup({
  width = 120,
})

vim.keymap.set("n", "<leader>m", ":NoNeckPain<cr>",
  {silent = true, noremap = true, desc = "Toggle no neck pain"}
)

