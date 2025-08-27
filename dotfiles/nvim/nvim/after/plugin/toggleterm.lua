local toggleterm = require("toggleterm")
local Terminal  = require("toggleterm.terminal").Terminal

toggleterm.setup {
  shade_terminals = false,
  persist_size = false,
  direction = "float",
  float_opts = {
    border = "single",
    winblend = 0,
    width = function()
      return math.ceil(vim.o.columns * 0.85)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.85)
    end,
  }
}

local float_term = Terminal:new({hidden = true})
float_term:spawn()

local function float_term_toggle()
  float_term:toggle()
end

vim.keymap.set("n", "<leader>t", float_term_toggle, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<C-s>", float_term_toggle, { noremap = true, silent = true, desc = "Hide floating terminal" })

-- Delete terminal buffers to allow :xa to exit when terminal open.
vim.api.nvim_create_autocmd("ExitPre", {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

