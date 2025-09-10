vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<C-e>")', { expr = true, silent = true })

local copilotChat = require("CopilotChat")
local ui = vim.api.nvim_list_uis()[1]
local width = math.floor(ui.width * 0.9)
local height = math.floor(ui.height * 0.9)
copilotChat.setup({
  window = {
    layout = "float",
    width = width,
    height = height,
    border = "rounded",
  },
})

-- vim.keymap.set('n', '<leader>gl', ':CopilotChatToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>gl', function()
  local file = vim.fn.expand('%:p')
  copilotChat.toggle()

  copilotChat.ask("#filename " .. file, { selection = false })
end, { noremap = true, silent = true, desc = "Toggle Copilot Chat and send current file context" })

vim.keymap.set('x', '<leader>gl', function()
  local chat = require("CopilotChat")

  -- Get the visual selection range
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get lines in the visual selection
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

  -- Join lines into a single string, trim trailing spaces
  local selection_text = table.concat(lines, "\n"):gsub("%s+$", "")

  -- Send selection as prompt to CopilotChat
  chat.ask(selection_text, { selection = true })
end, { noremap = true, silent = true, desc = "Send visual selection to CopilotChat" })

