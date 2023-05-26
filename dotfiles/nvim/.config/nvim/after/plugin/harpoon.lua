require("harpoon").setup({
   -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
   save_on_toggle = false,

   -- saves the harpoon file upon every change. disabling is unrecommended.
   save_on_change = true,

   -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
   enter_on_sendcmd = false,

   -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
   tmux_autoclose_windows = false,

   -- filetypes that you want to prevent from adding to the harpoon list menu.
   excluded_filetypes = { "harpoon" },

   -- set marks specific to each git branch inside git repository
   mark_branch = false,

   -- enable tabline with harpoon marks
   tabline = false,
   tabline_prefix = "   ",
   tabline_suffix = "   ",
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })

vim.keymap.set("n", "tt", function() ui.nav_file(1) end, { desc = "Jump to Harpoon file 1" })
vim.keymap.set("n", "tj", function() ui.nav_file(2) end, { desc = "Jump to Harpoon file 2" })
vim.keymap.set("n", "tk", function() ui.nav_file(3) end, { desc = "Jump to Harpoon file 3" })
vim.keymap.set("n", "tl", function() ui.nav_file(4) end, { desc = "Jump to Harpoon file 4" })

vim.keymap.set("n", "tn", function() ui.nav_next() end, { desc = "Jump to next Harpoon mark" })
vim.keymap.set("n", "tp", function() ui.nav_prev() end, { desc = "Jump to previous Harpoon mark" })
