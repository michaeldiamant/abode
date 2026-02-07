require("gruvbox").setup({
  contrast = "soft",
  overrides = {
    SignColumn = { bg = "#32302f" }, -- Match background color of line numbers.
  }
})

vim.cmd.colorscheme("gruvbox")

