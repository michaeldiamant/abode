require("gruvbox").setup({
  contrast = "soft",
  overrides = {
    -- SignColumn = { bg = "#32302f" }, -- Old dark-mode background; kept for easy revert.
    SignColumn = { bg = "#f2e5bc" }, -- Match gruvbox light-soft main editor background.
    iCursor = { fg = "#f2e5bc", bg = "#3c3836" }, -- Visible dark cursor in insert mode for light background.
  }
})

vim.o.background = "light"
vim.cmd.colorscheme("gruvbox")

