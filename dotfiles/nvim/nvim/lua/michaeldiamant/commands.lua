-- Highlight yanked text.
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank({timeout=500})]]

-- Save all buffers on focus lost.
-- * Source: https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
-- * For tmux integration: `set -g focus-events on`
vim.cmd[[:au FocusLost * :wa]]

-- Reload stale buffers when file system changed outside of nvim.
vim.cmd[[:set autoread]]

-- Show NERDTree when no visible buffers are open on startup.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local buffers = vim.fn.getbufinfo({buflisted = 1})
    local visible_buffer_found = false
    local visible_buffer_name = nil
    for _, buf in ipairs(buffers) do
      -- bufwinnr returns the window number if buffer is visible in a window, -1 if not
      if vim.fn.bufwinnr(buf.bufnr) ~= -1 then
        visible_buffer_found = true
        visible_buffer_name = vim.api.nvim_buf_get_name(buf.bufnr)
        break
      end
    end

    if not visible_buffer_found or (visible_buffer_name == '') then
      -- No visible buffers, open NERDTree
      vim.cmd("NERDTree")
    end
  end,
})
